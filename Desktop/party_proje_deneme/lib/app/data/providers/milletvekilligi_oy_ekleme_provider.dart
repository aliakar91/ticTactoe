import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';

class MilletvekilligiOyEklemeProvider {
  final _networkService = Get.find<NetworkService>();

  Future<dynamic> getMemberOfParliament() async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: "https://6450d4fba32219691152df86.mockapi.io/api/pokemons",
    );
  }

  Future<dynamic> getMemberOfParliamentVoteNumbers() async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: "https://6450d4fba32219691152df86.mockapi.io/api/sandik",
    );
  }

  Future<dynamic> milletvekilleriAdaylari(int type) async {
    return await _networkService.request(
      requestType: RequestType.get,
      url: "${ApiUrls.baseUrl}/candidates/$type",
    );
  }
}
