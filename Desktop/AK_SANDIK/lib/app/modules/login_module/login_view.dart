import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/commons/app_bar_title.dart';
import 'package:ak_sandik/app/commons/app_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/modules/login_module/login_controller.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

//ignore: must_be_immutable
class LoginView extends StatelessWidget {
  final controller = Get.find<LoginController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController telNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
    mask: '0 (###) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppBarTitle(
          text: LocalizationKeys.appBarSandik,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 30.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocalizationKeys.giris,
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.blueGreyShade700,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inspiration",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(
                        FontAwesomeIcons.users,
                        size: 25,
                        color: AppColors.blueGreyShade700,
                      ),
                    ),
                  ],
                ),
                buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildForm(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          controller: telNoController,
          requiredInputLength: 17,
          errorMessage: LocalizationKeys.telUyariMesaj,
          hintText: LocalizationKeys.telNo,
          icon: const Icon(FontAwesomeIcons.addressCard),
          keyboardType: TextInputType.phone,
          textInputFormatter: [maskFormatter],
          onChanged: (value) {
            if (value.isEmpty) {
              telNoController.value = const TextEditingValue(text: "0");
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 20),
          child: AppFormField(
            controller: passwordController,
            hintText: LocalizationKeys.sifre,
            keyboardType: TextInputType.text,
            icon: const Icon(FontAwesomeIcons.lock),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              String phoneNumber = "0${maskFormatter.getUnmaskedText()}";
              if (formKey.currentState!.validate()) {
                controller.login(phoneNumber, passwordController.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              LocalizationKeys.giris,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 10.h,
          ),
          child: Image.asset(
            'assets/images/donmezoglu.png',
            height: 150.h,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
