import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_proje_deneme/app/commons/toast_message.dart';
import 'package:party_proje_deneme/app/modules/login_module/login.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/data/repositories/login_repository.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim_view.dart';
import 'package:party_proje_deneme/app/modules/sonuclar_sayfasi_module/sonuclar_sayfasi.dart';

class LoginController extends GetxController {
  final _isUserLoggedIn = GetStorage().hasData(BoxStorageKeys.loggedIn).obs;
  bool get isUserLoggedIn => _isUserLoggedIn.value;
  set isUserLoggedIn(value) => _isUserLoggedIn.value = value;
  final loginRepository = LoginRepository();
  final userData = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    isUserLoggedIn = await GetStorage().hasData(BoxStorageKeys.loggedIn);
    await routePages();
  }

  routePages() {
    if (isUserLoggedIn) {
      const CircularProgressIndicator();
      Get.offAll(() => SandiklarimView());
    } else {
      Get.offAll(() => LoginView());
    }
  }

  loginInformation(String tcNo, String password) async {
    bool isLogin = await loginRepository.loginInfo(tcNo, password);
    if (isLogin) {
      LoginShowToastMessage.showToastMessage(
        "GİRİŞ BAŞARILI",
        color: Colors.green,
      );
      await Future.delayed(const Duration(microseconds: 700));
      Get.offAll(() => SandiklarimView());
    } else {
      LoginShowToastMessage.showToastMessage(
        "LÜTFEN BİLGİLERİNİZİ KONTROL EDİNİZ",
        color: Colors.red,
      );
    }
  }
}
