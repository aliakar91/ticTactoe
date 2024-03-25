import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/data/providers/election_provider.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ElectionRepository {
  final _electionProvider = MayorProvider();

  Future<LinkedBallotBox> getBallotBox(String id) async {
    var response = await _electionProvider.getBallotBox(id);

    if (response.statusCode == HttpStatus.ok) {
      return LinkedBallotBox.fromJson(response.body);
    }
    throw Exception("HTTP Request failed with status: ${response.statusCode}");
  }

  Future<dynamic> sendVotesData(List<Map<String, dynamic>> sendVote) async {
    var response = await _electionProvider.sendVotesData(sendVote);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> sendReportImages(
    int id,
    String? districtPhoto,
    String? councilPhoto,
    String? cityPhoto,
  ) async {
    List<http.MultipartFile> multipartFileList;
    multipartFileList = [];
    if (cityPhoto != null) {
      multipartFileList.add(
        await http.MultipartFile.fromPath(
          "city_report_image",
          cityPhoto,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }
    if (districtPhoto != null) {
      multipartFileList.add(
        await http.MultipartFile.fromPath(
          "district_report_image",
          districtPhoto,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }
    if (councilPhoto != null) {
      multipartFileList.add(
        await http.MultipartFile.fromPath(
          "council_report_image",
          councilPhoto,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }
    var response =
        await _electionProvider.sendReportImages(id, multipartFileList);
    return response;
  }
}
