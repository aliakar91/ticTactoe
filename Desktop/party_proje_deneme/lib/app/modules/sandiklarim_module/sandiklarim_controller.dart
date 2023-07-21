import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/data/repositories/sandiklarim_repository.dart';

class SandiklarimController extends GetxController {
  final _sandiklarimRepository = SandiklarimRepository();

  final _sandiklarimList = <KisilerSandik>[].obs;

  List<KisilerSandik> get sandiklarimList => _sandiklarimList;

  set sandiklarimList(value) => _sandiklarimList.value = value;

  Future<dynamic> sandiklariGetir() async {
    sandiklarimList = await _sandiklarimRepository.kisiSandiklari();
  }

  @override
  void onReady() async {
    await sandiklariGetir();
    super.onReady();
  }
}
