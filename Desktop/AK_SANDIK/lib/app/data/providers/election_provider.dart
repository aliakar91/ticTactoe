import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ak_sandik/app/data/enums/request_type.dart';
import 'package:ak_sandik/app/services/network_service.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';

class MayorProvider {
  final _networkService = Get.find<NetworkService>();

  Future<dynamic> getBallotBox(String id) async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: ApiUrls.getBox(id),
    );
  }

  Future<dynamic> sendVotesData(List<Map<String, dynamic>> sendVote) async {
    return await _networkService.request(
      requestType: RequestType.post,
      url: ApiUrls.addBallotBox,
      data: sendVote,
    );
  }

  Future<dynamic> sendReportImages(
      int id, List<http.MultipartFile>? multipartFileList) async {
    final Map<String, String> data = {"ballot_box_id": id.toString()};
    return await _networkService.request(
      requestType: RequestType.multiPartPost,
      url: ApiUrls.addImage,
      data: data,
      multipartFileList: multipartFileList,
      headers: <String, String>{"Content-Type": "multipart/form-data"},
    );
  }
}
