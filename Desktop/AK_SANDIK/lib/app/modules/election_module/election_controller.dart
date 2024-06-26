import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ak_sandik/app/data/models/box.dart';
import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/data/models/candidate.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/commons/app_toast_message.dart';
import 'package:ak_sandik/app/data/enums/ballot_box_status.dart';
import 'package:ak_sandik/app/data/repositories/election_repository.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';
import 'package:ak_sandik/app/data/models/network_response.dart';
import 'package:image_picker/image_picker.dart';

class ElectionController extends GetxController {
  final _isLoading = true.obs;
  final _imageLoading = false.obs;
  File? districtPhoto;
  File? councilPhoto;
  File? cityPhoto;
  final Set<int> _usedNumbers = {};
  final box = GetStorage();
  late LinkedBallotBox linkedBallotBox;
  final electionRepository = ElectionRepository();
  late DateTime lastSendAt;
  Timer? _timer;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  bool get imageLoading => _imageLoading.value;

  set imageLoading(value) => _imageLoading.value = value;

  final documentScannerController = DocumentScannerController();

  @override
  void onReady() {
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _timer!.cancel();
  }

  Future<dynamic> createBallotBox(String id, String status) async {
    var readVoteList = await box.read(id);
    bool isNotNull = readVoteList != null && status != Status.three.value;
    if (isNotNull) {
      linkedBallotBox = LinkedBallotBox.fromJson(readVoteList);
    } else {
      linkedBallotBox = await electionRepository.getBallotBox(id);
    }
    linkedBallotBox.dateTime = DateTime.now();
    lastSendAt = DateTime.now();
    toggleLoading();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    update();
  }

  void toggleImageLoading() {
    imageLoading = !imageLoading;
    update();
  }

  Future<dynamic> sendReportImage() async {
    toggleImageLoading();
    NetworkResponse res = await electionRepository.sendReportImages(
      int.parse(linkedBallotBox.id),
      districtPhoto?.path,
      councilPhoto?.path,
      cityPhoto?.path,
    );
    toggleImageLoading();
    if (res.statusCode == HttpStatus.ok) {
      AppToastMessage.showSuccessMessage(
        LocalizationKeys.tutanakEklemeBasariMesaj,
      );
      isStatusThree() ? Get.offAllNamed(Routes.mainScreen) : uploadImages(res);
    } else {
      AppToastMessage.showErrorMessage(LocalizationKeys.eklemeHataMesaj);
    }
  }

  int calculateTotalNumber(String type) {
    Box box = linkedBallotBox.getBoxType(type);
    return (box.invalidVote +
        box.emptyVote +
        box.voted +
        calculatePartyInvalidVote(type));
  }

  int calculatePartyInvalidVote(String type) {
    int invalidPartyVote = 0;
    linkedBallotBox.getBoxType(type).candidates.asMap().forEach((_, candidate) {
      if (candidate.showInvalidVote == 1) {
        invalidPartyVote += candidate.invalidVote;
      }
    });
    return invalidPartyVote;
  }

  void setVote(String type, Candidate candidate, int vote) {
    int totalVote = linkedBallotBox.totalVote;
    int voteDiff = vote - candidate.vote;
    int currentVote = calculateTotalNumber(type) + voteDiff;

    if (currentVote <= totalVote && vote >= 0) {
      linkedBallotBox.getBoxType(type).voted += voteDiff;
      candidate.vote += voteDiff;
    } else if (currentVote > totalVote) {
      AppToastMessage.showErrorMessage(LocalizationKeys.alertUyariMesaj);
    }
    saveBox();
  }

  void setInvalidVote(String type, int vote, bool isInvalid) {
    Box box = linkedBallotBox.getBoxType(type);
    int totalVote = linkedBallotBox.totalVote;
    int currentVote = calculateTotalNumber(type) +
        (isInvalid ? vote - box.invalidVote : vote - box.emptyVote);

    if (currentVote <= totalVote && vote >= 0) {
      isInvalid ? box.invalidVote = vote : box.emptyVote = vote;
    } else if (currentVote > totalVote) {
      AppToastMessage.showErrorMessage(LocalizationKeys.alertUyariMesaj);
    }
    saveBox();
  }

  void setPartyInvalidVote(String type, int vote, int index) {
    Box box = linkedBallotBox.getBoxType(type);
    int totalVote = linkedBallotBox.totalVote;
    int? partyInvalid = box.candidates[index].invalidVote;
    int currentVote = calculateTotalNumber(type) + vote - partyInvalid;

    if (currentVote <= totalVote && vote >= 0) {
      box.candidates[index].invalidVote += vote - partyInvalid;
    } else if (currentVote > totalVote) {
      AppToastMessage.showErrorMessage(LocalizationKeys.alertUyariMesaj);
    }
    saveBox();
  }

  Future pickImageFromCameraOrGallery(
    ImageSource source,
    int status,
  ) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      toggleImageLoading();
      final dir = await path_provider.getTemporaryDirectory();
      int randomNumber = generateUniqueRandomNumber(1, 100);
      final targetPath = '${dir.absolute.path}/$randomNumber.jpg';
      XFile? compressImage =
          await compressAndGetFile(File(image.path), targetPath);

      if (compressImage != null) {
        if (status == 0) {
          districtPhoto = File(compressImage.path);
          districtPhoto == null
              ? AppToastMessage.showErrorMessage(
                  LocalizationKeys.fotoEklemeHatasi)
              : AppToastMessage.showSuccessMessage(
                  LocalizationKeys.iskenderunBasariMesaj,
                );
        } else if (status == 1) {
          councilPhoto = File(compressImage.path);
          councilPhoto == null
              ? AppToastMessage.showErrorMessage(
                  LocalizationKeys.fotoEklemeHatasi)
              : AppToastMessage.showSuccessMessage(
                  LocalizationKeys.meclisBasariMesaj,
                );
        } else {
          cityPhoto = File(compressImage.path);
          cityPhoto == null
              ? AppToastMessage.showErrorMessage(
                  LocalizationKeys.fotoEklemeHatasi)
              : AppToastMessage.showSuccessMessage(
                  LocalizationKeys.buyukSehirBasariMesaj,
                );
        }
      } else {
        AppToastMessage.showErrorMessage(LocalizationKeys.fotoEklemeHatasi);
      }
      toggleImageLoading();
    } catch (e) {
      AppToastMessage.showErrorMessage(
        LocalizationKeys.islemHataMesaj,
      );
    }
    update();
  }

  Future<void> saveBox() async {
    linkedBallotBox.dateTime = DateTime.now();
    await box.write(linkedBallotBox.id, linkedBallotBox.toJson());
    update();
  }

  void sendElectionResults() async {
    List<Map<String, dynamic>> candidateList = [
      createVoteResult(VoteType.city.value),
      createVoteResult(VoteType.district.value),
      createVoteResult(VoteType.council.value)
    ];
    bool isSuccess = await electionRepository.sendVotesData(candidateList);
    if (isSuccess) {
      lastSendAt = DateTime.now();
    }
    update();
  }

  Map<String, dynamic> createVoteResult(String type) {
    Box box = linkedBallotBox.getBoxType(type);
    List<Map<String, dynamic>> candidateList = [];
    int candidateInvalidVote = 0;

    for (var candidate in box.candidates) {
      candidateInvalidVote += candidate.invalidVote;
      candidateList.add(
        {
          "id": int.parse(candidate.id),
          "vote": candidate.vote,
          "invalid_vote": candidate.invalidVote,
        },
      );
    }
    final Map<String, dynamic> data = {
      "ballot_box_id": int.parse(linkedBallotBox.id),
      "type": type,
      "empty_votes": box.emptyVote,
      "invalid_votes": box.invalidVote + candidateInvalidVote,
      "candidates_with_votes": candidateList,
    };
    return data;
  }

  bool isStatusThree() {
    return ((linkedBallotBox.getReportImage(VoteType.city.value) != null ||
            cityPhoto != null) &&
        (linkedBallotBox.getReportImage(VoteType.district.value) != null ||
            districtPhoto != null) &&
        (linkedBallotBox.getReportImage(VoteType.council.value) != null ||
            councilPhoto != null));
  }

  bool isExistPhotosOnApi() {
    return (linkedBallotBox.getReportImage(VoteType.city.value) != null ||
        linkedBallotBox.getReportImage(VoteType.district.value) != null ||
        linkedBallotBox.getReportImage(VoteType.council.value) != null);
  }

  void uploadImages(NetworkResponse res) {
    toggleImageLoading();
    if (cityPhoto != null) {
      linkedBallotBox.getBoxType(VoteType.city.value).reportImage =
          res.body['linked_boxes'][0]['report_image'];
    }
    if (districtPhoto != null) {
      linkedBallotBox.getBoxType(VoteType.district.value).reportImage =
          res.body['linked_boxes'][1]['report_image'];
    }
    if (councilPhoto != null) {
      linkedBallotBox.getBoxType(VoteType.council.value).reportImage =
          res.body['linked_boxes'][2]['report_image'];
    }
    saveBox();
    toggleImageLoading();
    cityPhoto = null;
    districtPhoto = null;
    councilPhoto = null;
    Get.offNamed(Routes.mayorPhotoScreen);
  }

  void startTimer() {
    int waitTime = 35 + Random().nextInt(55);
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (waitTime == 0) {
          waitTime = 35 + Random().nextInt(55);
          if (linkedBallotBox.dateTime!.isAfter(lastSendAt)) {
            sendElectionResults();
          }
        } else {
          waitTime--;
        }
      },
    );
  }

  void stopTimer() {
    _timer!.cancel();
  }

  Future<XFile?> compressAndGetFile(
    File file,
    String targetPath,
  ) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      minHeight: 1500,
      minWidth: 1500,
    );
    return result;
  }
  int generateUniqueRandomNumber(int min, int max) {
    Random random = Random();
    int randomNumber;
    do {
      randomNumber = min + random.nextInt(max - min + 1);
    } while (_usedNumbers.contains(randomNumber));
    _usedNumbers.add(randomNumber);
    return randomNumber;
  }
}
