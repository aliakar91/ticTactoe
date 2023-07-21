import 'package:get/get.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme.dart';

class CumhurbaskanligiOyEklemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CumhurbaskanligiOyEklemeController());
  }
}
