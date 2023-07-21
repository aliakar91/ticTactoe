import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';

class SandiklarimProvider {
  final _networkService = Get.put(NetworkService());

  kisiSandiklari() async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: "${ApiUrls.baseUrl}/user-ballot-boxes",
    );
  }
}
