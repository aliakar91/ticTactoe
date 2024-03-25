import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:ak_sandik/app/data/repositories/ballot_box_repository.dart';

class MainController extends GetxController {
  final _ballotBoxRepository = BallotBoxRepository();
  final _ballotBoxList = <BallotBox>[].obs;

  List<BallotBox> get ballotBoxList => _ballotBoxList;

  set ballotBoxList(value) => _ballotBoxList.value = value;

  Future<bool> isLoggedIn() async {
    return GetStorage().hasData(BoxStorageKeys.loggedIn);
  }

  Future<dynamic> getBallotBoxes() async {
    ballotBoxList = await _ballotBoxRepository.getBallotBoxes();
    update();
  }
}
