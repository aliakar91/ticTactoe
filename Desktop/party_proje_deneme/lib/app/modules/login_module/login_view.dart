import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/login_form_field.dart';
import 'package:party_proje_deneme/app/globals/styles/app_colors.dart';
import 'package:party_proje_deneme/app/modules/login_module/login.dart';

class LoginView extends StatelessWidget implements PreferredSizeWidget {
  LoginView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = LoginController();
  TextEditingController tcController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              "SANDIK",
              style: TextStyle(fontSize: 26),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Form(
        key: formKey,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Giriş",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inspiration",
                      ),
                    ),
                    Icon(FontAwesomeIcons.users,
                        size: 25, color: Colors.black87),
                  ],
                ),
                Column(
                  children: [
                    AppFormField(
                      controller: tcController,
                      requiredInputLength: 10,
                      errorMessage: "Tc No 11 karakter olmalıdır",
                      hintText: "Tc No",
                      icon: const Icon(FontAwesomeIcons.addressCard),
                      keyboardType: TextInputType.phone,
                    ),
                    AppFormField(
                      controller: passwordController,
                      hintText: "Şifre",
                      icon: const Icon(FontAwesomeIcons.lock),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              controller.loginInformation(
                                  tcController.text, passwordController.text);
                            } else {}
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          child: const Text(
                            "Giriş",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/donmezoglu.png',
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
