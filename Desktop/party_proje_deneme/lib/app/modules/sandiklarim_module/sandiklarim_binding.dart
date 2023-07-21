import 'package:get/get.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';

class SandiklarimBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SandiklarimController());
  }
}
