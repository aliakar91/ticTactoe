import 'package:get/get.dart';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:ak_sandik/app/commons/app_toast_message.dart';
import 'package:ak_sandik/app/data/repositories/auth_repository.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class LoginController extends GetxController {
  final authRepository = AuthRepository();

  Future<void> login(String tcNo, String password) async {
    bool isLogin = await authRepository.login(tcNo, password);

    if (isLogin) {
      Get.offAllNamed(Routes.mainScreen);
    } else {
      AppToastMessage.showErrorMessage(
          LocalizationKeys.kullaniciBilgiHataMesaj);
    }
  }
}
