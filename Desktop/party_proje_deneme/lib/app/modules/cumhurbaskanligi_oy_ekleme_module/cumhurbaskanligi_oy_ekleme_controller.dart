import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_proje_deneme/app/data/models/box.dart';
import 'package:party_proje_deneme/app/commons/toast_message.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/data/repositories/cumhurbaskanligi_oy_ekleme_repository.dart';

import '../sandiklarim_module/sandiklarim_controller.dart';

class CumhurbaskanligiOyEklemeController extends GetxController {
  final sandiklarimController = Get.put(SandiklarimController());
  List<Map<String, dynamic>> candidateWithVoteList = [];
  File? photo;
  final cumhurbaskanligiOyEklemeRepository = CumhurbaskanligiOyEklemeRepository();
  final box = GetStorage();
  final _cumhurbaskaniAdaylarList = <Candidate>[].obs;
  final _extraListItems = <Candidate>[].obs;

  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  int start = 30;

  List<Candidate> get cumhurbaskaniAdaylarList => _cumhurbaskaniAdaylarList;

  set cumhurbaskaniAdaylarList(value) => _cumhurbaskaniAdaylarList.value = value;

  List<Candidate> get extraListItems => _extraListItems;

  set extraListItems(value) => _extraListItems.value = value;

  @override
  void onReady() async {
    var readVoteList = box.read(StorageVoteKey.storageVoteSaveKey);
    if (readVoteList != null) {
      print("if box");
      Box boxObject = Box.fromJson(readVoteList);
      cumhurbaskaniAdaylarList = boxObject.candidate;
      print("321$cumhurbaskaniAdaylarList");
      print("deneme $readVoteList");
      print("list $extraListItems");
      box.remove(StorageVoteKey.storageVoteSaveKey);
    } else {
      await cumhurbaskaniAdaylari(1);
      // box.remove(StorageVoteKey.storageVoteSaveKey);
      print("else box");
    }
    requestForVoting();
    super.onReady();
  }

  int calculateInvalidVote() {
    int a = 0;
    for (int i = 0; i < cumhurbaskaniAdaylarList.length; i++) {
      if (cumhurbaskaniAdaylarList[i].invalidVote != null) {
        a += cumhurbaskaniAdaylarList[i].invalidVote!;
      }
    }
    //  int invalid = tüm geçersizden - a
    return a; // invalid return
  }

  Future<void> cumhurbaskaniAdaylari(int type) async {
    cumhurbaskaniAdaylarList = await cumhurbaskanligiOyEklemeRepository.cumhurbaskanlariAdaylariGetir(type);
    update();
  }

  void addInvalidAndEmptyVoteList(KisilerSandik kisilerSandik) {
    extraListItems.add(
      Candidate(
        id: "125585545995656",
        name: "Diğer Gecersiz Oy",
        image: "",
        type: "1",
        invalidVote: int.parse(kisilerSandik.invalidVote) - calculateInvalidVote(),
      ),
    );
    extraListItems.add(
      Candidate(
        id: "11242148521421543",
        name: "Kullanılmayan Oy",
        image: "",
        type: "1",
        invalidVote: int.parse(kisilerSandik.emptyVote), // sayılmayan oylar gelecek
      ),
    );
    update();
  }

  final List<Candidate> adaylar = [
    Candidate(
      image: 'https://pbs.twimg.com/profile_images/1151410974240444416/yVvaD7hU_400x400.jpg',
      name: 'Recep Tayyip\n Erdoğan',
      type: "0",
      id: "1",
    ),
    Candidate(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4R13ul0oJlQosnTsL4CgUfDhoTz1NMPUzWAWvmeP6nECj90u9NIxKRxsTlrAPkAOD6Rk&usqp=CAU',
      name: 'Muharrem İnce',
      type: "0",
      id: "1",
    ),
    Candidate(
      image: 'https://pbs.twimg.com/profile_images/1639741032412708866/gtT0w0lj_400x400.jpg',
      name: 'Kemal Kılıçdaroğlu',
      type: "0",
      id: "1",
    ),
    Candidate(
      image:
          'https://cdn1.img.sputniknews.com.tr/img/07e7/03/13/1068456852_0:0:864:486_1920x0_80_0_0_41a4f8386382dd10036ed1bbd69a4835.jpg.webp',
      name: 'Sinan Oğan ',
      type: "0",
      id: "1",
    ),
  ].obs;

  voteSaveFunc(KisilerSandik kisilerSandik) async {
    Box boxObject = Box(
      id: kisilerSandik.id,
      sandikNo: int.parse(kisilerSandik.no),
      secmenSayisi: int.parse(kisilerSandik.totalVote),
      gecerliOy: int.parse(kisilerSandik.voted),
      gecersizOy: int.parse(kisilerSandik.invalidVote),
      sayilanOy: (int.parse(kisilerSandik.voted) + int.parse(kisilerSandik.invalidVote)),
      kullanilmayanOy: int.parse(kisilerSandik.emptyVote),
      cityName: kisilerSandik.cityName,
      districtName: kisilerSandik.districtName,
      candidate: cumhurbaskaniAdaylarList,
    );
    await box.write(StorageVoteKey.storageVoteSaveKey, boxObject.toJson());
  }

  void increaseVoteNumber(
    bool isInvalid,
    KisilerSandik kisilerSandik,
    Candidate candidate,
    bool isVoteEmpty,
  ) {
    int totalNumber = 0;
    for (int i = 0; i < cumhurbaskaniAdaylarList.length; i++) {
      totalNumber =
          totalNumber + cumhurbaskaniAdaylarList[i].vote!.toInt() + cumhurbaskaniAdaylarList[i].invalidVote!.toInt();
    }
    totalNumber = totalNumber + extraListItems[0].invalidVote! + extraListItems[1].emptyVote!;
    print(totalNumber);
    if (isInvalid) {
      if (totalNumber < int.parse(kisilerSandik.totalVote)) {
        if (isVoteEmpty) {
          kisilerSandik.emptyVote = (int.parse(kisilerSandik.emptyVote) + 1).toString();
          candidate.vote = (candidate.vote! + 1);
        } else {
          kisilerSandik.invalidVote = (int.parse(kisilerSandik.invalidVote) + 1).toString();
        }
        candidate.invalidVote = (candidate.invalidVote! + 1);
      } else {
        return;
      }
    } else {
      if (totalNumber < int.parse(kisilerSandik.totalVote)) {
        candidate.vote = (candidate.vote! + 1);
        kisilerSandik.voted = (int.parse(kisilerSandik.voted) + 1).toString();
      } else {
        return;
      }
    }
    update();
    voteSaveFunc(kisilerSandik);
  }

  decreaseVoteNumber(
    bool isInvalid,
    Candidate candidate,
    KisilerSandik kisilerSandik,
    bool isVoteEmpty,
  ) async {
    if (!isInvalid && candidate.vote! > 0) {
      candidate.vote = (candidate.vote! - 1);
      kisilerSandik.voted = (int.parse(kisilerSandik.voted) - 1).toString();
    } else if (isInvalid && isVoteEmpty && candidate.invalidVote! > 0) {
      kisilerSandik.emptyVote = (int.parse(kisilerSandik.emptyVote) - 1).toString();
      candidate.invalidVote = (candidate.invalidVote! - 1);
    } else if (isInvalid && candidate.invalidVote! > 0) {
      candidate.invalidVote = (candidate.invalidVote! - 1);
      kisilerSandik.invalidVote = (int.parse(kisilerSandik.invalidVote) - 1).toString();
    } else {
      return;
    }
    update();

    voteSaveFunc(kisilerSandik);
    await Future.delayed(const Duration(seconds: 30));
    update();
  }

  arrangeVoteNumber(int voteNumber, int voteType, bool isInvalid, KisilerSandik kisilerSandik, Candidate candidate,
      bool isVoteEmpty) {
    int totalNumber = 0;
    for (int i = 0; i < cumhurbaskaniAdaylarList.length; i++) {
      totalNumber =
          totalNumber + cumhurbaskaniAdaylarList[i].vote!.toInt() + cumhurbaskaniAdaylarList[i].invalidVote!.toInt();
      update();
    }
    totalNumber = totalNumber - voteType;

    if (isInvalid) {
      if (isVoteEmpty) {
        kisilerSandik.emptyVote = voteNumber.toString();
        candidate.invalidVote = voteNumber;
      } else {
        if (voteNumber > int.parse(kisilerSandik.totalVote)) {
          candidate.invalidVote = int.parse(kisilerSandik.totalVote) - totalNumber;
        } else {
          if (voteNumber > int.parse(kisilerSandik.totalVote) - totalNumber) {
            candidate.invalidVote = int.parse(kisilerSandik.totalVote) - totalNumber;
          } else {
            candidate.invalidVote = voteNumber;
          }
        }
      }
      kisilerSandik.invalidVote = (int.parse(kisilerSandik.invalidVote) - voteType + candidate.invalidVote!).toString();
    } else {
      if (voteNumber > int.parse(kisilerSandik.totalVote)) {
        candidate.vote = int.parse(kisilerSandik.totalVote) - totalNumber;
      } else {
        if (voteNumber > int.parse(kisilerSandik.totalVote) - totalNumber) {
          candidate.vote = int.parse(kisilerSandik.totalVote) - totalNumber;
        } else {
          candidate.vote = voteNumber;
        }
      }
      kisilerSandik.voted = (int.parse(kisilerSandik.voted) - voteType + candidate.vote!).toString();
    }
    update();
    voteSaveFunc(kisilerSandik);
  }

  cumhurbaskanligiOyEkleme(SendVoteForPresidency sendVote) async {
    bool isAdded = await cumhurbaskanligiOyEklemeRepository.cumhurbaskanligiOyEkleme(sendVote);
    if (isAdded) {
      await Future.delayed(const Duration(milliseconds: 700));
    } else {
      LoginShowToastMessage.showToastMessage(
        "Ekleme sırasında bir hata oluştu",
        color: Colors.red,
      );
      return;
    }
  }

  // cumhurbaskanligiFotografEkleme(int id, File image) async {
  //   bool isAdded = await cumhurbaskanligiOyEklemeRepository.cumhurbaskanligiFotografEkleme(id, image);
  //   if (isAdded) {
  //     await Future.delayed(const Duration(milliseconds: 700));
  //   } else {
  //     LoginShowToastMessage.showToastMessage(
  //       "Fotoğraf ekleme sırasında bir hata oluştu",
  //       color: Colors.red,
  //     );
  //     return;
  //   }
  // }

  Future pickImageFromCameraOrGallery(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      photo = imageTemporary;
    } catch (e) {
      LoginShowToastMessage.showToastMessage(
        "HATA OLUŞTU",
        color: Colors.red,
      );
    }
    update();
  }

  candidateAddVote() {
    for (var adaylar in cumhurbaskaniAdaylarList) {
      candidateWithVoteList.add(
        {
          "candidate_id": adaylar.id,
          "vote": adaylar.vote,
        },
      );
    }
  }

  void requestForVoting() {
    int start = 3;
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        print("-----------------");
        print(start);
        if (start == 0) {
          timer.cancel();

          var votesData = SendVoteForPresidency(
              ballotBoxId: int.parse(sandiklarimController.sandiklarimList[0].id),
              emptyVotes: int.parse(sandiklarimController.sandiklarimList[0].emptyVote),
              invalidVotes: int.parse(sandiklarimController.sandiklarimList[0].invalidVote),
              candidatesWithVotes: candidateWithVoteList);
          //await cumhurbaskanligiOyEkleme(votesData);
          //requestForVoting();
        } else {
          start--;
        }
      },
    );
  }
}
