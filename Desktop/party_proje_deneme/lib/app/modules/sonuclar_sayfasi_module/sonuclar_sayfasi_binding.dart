import 'package:get/get.dart';
import 'sonuclar_sayfasi_controller.dart';

class SonuclarSayfasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SonuclarSayfasiController());
  }
}
