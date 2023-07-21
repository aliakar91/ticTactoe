import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/data/models/network_response.dart';

class LoginProvider {
  final _networkService = Get.put(NetworkService());

  Future<NetworkResponse> loginInfo(String tcNo, String password) async {
    var data = {"tc_no": tcNo, "password": password};
    return await _networkService.request(
      requestType: RequestType.post,
      url: "${ApiUrls.baseUrl}/user-login",
      data: data,
    );
  }
}
