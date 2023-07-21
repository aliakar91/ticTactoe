import 'package:get/get.dart';
import 'package:party_proje_deneme/app/modules/login_module/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
