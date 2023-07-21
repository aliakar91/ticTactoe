import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/data/providers/cumhurbaskanligi_oy_ekleme_provider.dart';
import 'package:http_parser/http_parser.dart';

class CumhurbaskanligiOyEklemeRepository {
  final _cumhurbaskanligiOyEklemeProvider = CumhurbaskanligiOyEklemeProvider();

  Future<List<Candidate>> cumhurbaskanlariAdaylariGetir(int type) async {
    var response = await _cumhurbaskanligiOyEklemeProvider.cumhurbaskaniAdaylari(type);
    if (response.statusCode == HttpStatus.ok) {
      final cumhurbaskaniAdaylarList = response.body;
      return cumhurbaskaniAdaylarList.map<Candidate>((element) => Candidate.fromJson(element)).toList();
    }
    return <Candidate>[];
  }

  Future<dynamic> cumhurbaskanligiOyEkleme(SendVoteForPresidency sendVote) async {
    var response = await _cumhurbaskanligiOyEklemeProvider.cumhurbaskanligiOyEkleme(sendVote);
    print("Code ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> cumhurbaskanligiFotografEkleme(int id,List<http.MultipartFile>? multipartFileList) async {
    List<http.MultipartFile> multipartFileList;
    multipartFileList = [];
    multipartFileList.add(await http.MultipartFile.fromPath(
        "image","png",
        contentType: MediaType("image", "jpeg")));
    var response = await _cumhurbaskanligiOyEklemeProvider.cumhurbaskanligiFotografEkleme(id, multipartFileList);
    print("Response ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
