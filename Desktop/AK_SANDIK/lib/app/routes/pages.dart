import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:ak_sandik/app/modules/election_module/election_photo_view.dart';
import 'package:ak_sandik/app/modules/election_module/election_view.dart';
import 'package:get/get.dart';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:ak_sandik/app/modules/main_module/main_view.dart';
import 'package:ak_sandik/app/modules/login_module/login_view.dart';
import 'package:ak_sandik/app/modules/splash_module/splash_screen.dart';
import 'package:ak_sandik/app/modules/login_module/login_controller.dart';
import 'package:ak_sandik/app/modules/splash_module/splash_controller.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainView(),
    ),
    GetPage(
      name: Routes.mayorScreen,
      page: () => ElectionView(),
      binding: BindingsBuilder(() {
        Get.put(ElectionController());
      }),
    ),
    GetPage(
      name: Routes.mayorPhotoScreen,
      page: () => ElectionPhotoView(),
      binding: BindingsBuilder(() {
        Get.put(ElectionController());
      }),
    ),
  ];
}
