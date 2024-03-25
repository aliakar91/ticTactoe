import 'package:get/get.dart';
import 'package:ak_sandik/app/data/enums/request_type.dart';
import 'package:ak_sandik/app/services/network_service.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:ak_sandik/app/data/models/network_response.dart';

class AuthProvider {
  final networkService = Get.find<NetworkService>();

  Future<NetworkResponse> login(Map<String, dynamic> data) async {
    return await networkService.request(
      requestType: RequestType.post,
      url: ApiUrls.userLogin,
      data: data,
    );
  }
}
