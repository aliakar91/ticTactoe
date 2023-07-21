import 'package:get/get.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/modules/login_module/login_controller.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/modules/sonuclar_sayfasi_module/sonuclar_sayfasi_controller.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkService());
    Get.put(MilletvekiliOyEklemeController());
    Get.put(SonuclarSayfasiController());
    Get.put(LoginController());
    Get.put(SandiklarimController());
  }
}
