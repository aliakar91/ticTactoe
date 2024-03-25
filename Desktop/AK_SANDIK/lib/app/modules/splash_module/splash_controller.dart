import 'package:get/get.dart';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:ak_sandik/app/modules/main_module/main_controller.dart';

class SplashController extends GetxController {
  final mainController = Get.find<MainController>();

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      const Duration(milliseconds: AppConstants.delayForSplashScreen),
    );
    bool isLogin = await mainController.isLoggedIn();
    if (isLogin) {
      Get.offAllNamed(Routes.mainScreen);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
