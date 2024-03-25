import 'package:get/get.dart';
import 'package:ak_sandik/app/data/enums/request_type.dart';
import 'package:ak_sandik/app/services/network_service.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';

class MainProvider {
  final _networkService = Get.find<NetworkService>();

  Future<dynamic> getBallotBoxes() async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: ApiUrls.getBoxes,
    );
  }
}
