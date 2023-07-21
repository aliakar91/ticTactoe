import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/cumhurbaskanlik_adaylari_oy_sayilari.dart';
import 'package:party_proje_deneme/app/data/providers/milletvekilligi_oy_ekleme_provider.dart';

class MilletvekilligiOyEklemeRepository {
  final _milletvekilligiOyEklemeProvider = MilletvekilligiOyEklemeProvider();

  Future<List<CumhurbaskanlikAdaylariOySayilari>>
      getMemberOfParliamentsVoteNumberList() async {
    var response = await _milletvekilligiOyEklemeProvider
        .getMemberOfParliamentVoteNumbers();
    if (response.statusCode == HttpStatus.ok) {
      final voteNumberList = response.body;
      return voteNumberList
          .map<CumhurbaskanlikAdaylariOySayilari>(
              (element) => CumhurbaskanlikAdaylariOySayilari.fromJson(element))
          .toList();
    }
    return <CumhurbaskanlikAdaylariOySayilari>[];
  }

  Future<List<Candidate>> milletvekilleriAdaylari(int type) async {
    var response =
        await _milletvekilligiOyEklemeProvider.milletvekilleriAdaylari(type);
    if (response.statusCode == HttpStatus.ok) {
      final milletvekilleriAdaylarList = response.body;
      return milletvekilleriAdaylarList
          .map<Candidate>((element) => Candidate.fromJson(element))
          .toList();
    }
    return <Candidate>[];
  }
}
