import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';

class CumhurbaskanligiOyEklemeProvider {
  final _networkService = Get.find<NetworkService>();

  Future<dynamic> cumhurbaskaniAdaylari(int type) async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: "${ApiUrls.baseUrl}/candidates/$type",
    );
  }

  Future<dynamic> cumhurbaskanligiOyEkleme(SendVoteForPresidency sendVote) async {
    print("0123 ${sendVote.toJson()}");
    // Map<String,dynamic> abc = {
    //   "ballot_box_id":2,
    //   "candidates_with_votes":[
    //     {
    //       "candidate_id":1,
    //       "vote":125
    //     },
    //     {
    //       "candidate_id":2,
    //       "vote":40
    //     }
    //   ],
    //   "empty_votes":20,
    //   "invalid_votes":12
    // };
    return await _networkService.request(
      requestType: RequestType.post,
      url: ApiUrls.addBallotBox,
      data: sendVote.toJson(),
    );
  }

  Future<dynamic> cumhurbaskanligiFotografEkleme(int id, List<http.MultipartFile>? multipartFileList) async {
    final Map data = {
      "id": id,
    };
    return await _networkService.request(
      requestType: RequestType.multiPartPost,
      url: ApiUrls.addImage,
      data: data,
      multipartFileList: multipartFileList,
      headers: <String, String>{"Content-Type": "multipart/form-data"},
    );
  }
}
