import 'package:get/get.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MilletvekiliOyEklemeController());
  }
}
