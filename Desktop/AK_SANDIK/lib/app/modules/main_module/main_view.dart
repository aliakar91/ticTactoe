import 'package:ak_sandik/app/commons/app_alert_dialog.dart';
import 'package:ak_sandik/app/services/network_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/routes/routes.dart';
import 'package:ak_sandik/app/commons/app_bar_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ak_sandik/app/commons/loading_animation.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/modules/main_module/main_controller.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';
import 'package:ak_sandik/app/modules/main_module/widgets/ballot_box_card.dart';

//ignore: must_be_immutable
class MainView extends StatelessWidget {
  var controller = Get.find<MainController>();
  bool isLongPress = false;

  MainView({super.key}) {
    controller.getBallotBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.ballotBoxCard,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onLongPressStart: (_) {
                isLongPress = true;
                Future.delayed(const Duration(seconds: 2), () {
                  if (isLongPress) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppAlertDialog(
                          contentText:
                              "Çıkış yapmak istediğinize emin misiniz?",
                          onPressed: () {
                            NetworkService().signOut();
                          },
                        );
                      },
                    );
                  }
                });
              },
              onLongPressEnd: (_) {
                isLongPress = false;
              },
              child: AppBarTitle(
                text: LocalizationKeys.sandiklarim.toUpperCase(),
              ),
            ),
          ),
          body: controller.ballotBoxList.isEmpty
              ? const LoadingAnimation()
              : SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6.w),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.ballotBoxList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.mayorScreen,
                                  arguments: controller.ballotBoxList[index],
                                );
                              },
                              child: BallotBoxCard(
                                ballotBox: controller.ballotBoxList[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
