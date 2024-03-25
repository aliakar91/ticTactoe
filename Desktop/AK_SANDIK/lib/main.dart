import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ak_sandik/app/routes/pages.dart';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ak_sandik/app/services/network_service.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/modules/main_module/main_controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) {
        return GetMaterialApp(
          getPages: Pages.pages,
          initialRoute: Routes.splashScreen,
          initialBinding: BindingsBuilder(() {
            Get.put(NetworkService());
            Get.put(MainController());
          }),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Inspiration",
            appBarTheme: AppBarTheme(
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
