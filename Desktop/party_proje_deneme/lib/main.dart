import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_proje_deneme/app/globals/initial_binding.dart';
import 'package:party_proje_deneme/app/globals/styles/app_colors.dart';
import 'package:party_proje_deneme/app/modules/login_module/login_view.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inspiration",
        //primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: AppColors.primary,
        ),
      ),
      home: LoginView(),
    );
  }
}
