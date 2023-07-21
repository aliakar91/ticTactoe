import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:party_proje_deneme/app/services/network_service.dart';
import 'package:party_proje_deneme/app/globals/styles/app_colors.dart';
import 'package:party_proje_deneme/app/modules/login_module/login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/modules/sonuclar_sayfasi_module/sonuclar_sayfasi.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme.dart';

enum NavbarDropdownItems {
  logout,
}

class SandiklarimView extends StatelessWidget {
  final controller = Get.put(SandiklarimController());
  final loginController = Get.put(LoginController());


  SandiklarimView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Sandıklarım"),
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              onSelected: (NavbarDropdownItems value) => {
                loginController.isUserLoggedIn = false,
                NetworkService().signOut(),
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 24,
                ),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: NavbarDropdownItems.logout,
                  child: Text("Çıkış"),
                ),
              ],
            ),
          ],
        ),
        body: controller.sandiklarimList.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingAnimationWidget.bouncingBall(
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                      const Text(
                        'Veriler yükleniyor...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18   ,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.sandiklarimList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      FontAwesomeIcons.box,
                                      size: 50,
                                      color: Colors.cyan.shade800,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Sandık:",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          Text(
                                            controller
                                                .sandiklarimList[index].no,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${controller.sandiklarimList[index].districtName} / ${controller.sandiklarimList[index].cityName}",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppButton(
                                    text: "Cumhurbaşkanlığı",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CumhurbaskanligiOyEklemeSayfasi(
                                            cumhurbaskanlariSandik: controller
                                                .sandiklarimList[index],

                                            //cumhurbaskanlariSandik: controller.testSharedFunc(controller.sandiklarimList[index].id),
                                          ),
                                        ),
                                      );
                                      //box.read(BoxStorageKey.boxStorageVoteSaveKey);
                                      // cumhurbaskanligiController.sharedVoteSaveFunc(kisilerSandik);
                                      controller.update();
                                    },
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                  AppButton(
                                    text: "Milletvekili",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MilletvekiliOyEklemeView(
                                            milletvekilleriSandik: controller
                                                .sandiklarimList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    color: AppColors.primary,
                                    size: 16,
                                    width: 155,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AppButton(
                      text: "Sonuçları Göster",
                      onPressed: () {
                        //box.remove(BoxStorageKey.boxStorageVoteSaveKey);
                        Get.to(SonuclarSayfasiView());
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SonuclarSayfasiView()));
                      },
                      stadiumBorder: const StadiumBorder(),
                      size: 22,
                      isWidget: true,
                      icon: FontAwesomeIcons.check,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
