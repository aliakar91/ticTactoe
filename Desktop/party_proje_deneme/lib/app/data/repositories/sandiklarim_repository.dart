import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/data/providers/sandiklarim_provider.dart';

class SandiklarimRepository {
  final _sandiklarimProvider = SandiklarimProvider();

  Future<List<KisilerSandik>> kisiSandiklari() async {
    var response = await _sandiklarimProvider.kisiSandiklari();
    if (response.statusCode == HttpStatus.ok) {
      final kisiSandiklari = response.body;
      return kisiSandiklari
          .map<KisilerSandik>((element) => KisilerSandik.fromJson(element))
          .toList();
    }
    return <KisilerSandik>[];
  }
}
