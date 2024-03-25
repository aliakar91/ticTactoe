import 'dart:io';
import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:ak_sandik/app/modules/election_module/widgets/photo_tab_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/commons/app_bar_title.dart';
import 'package:ak_sandik/app/commons/app_media_query.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:ak_sandik/app/commons/app_alert_dialog.dart';
import 'package:ak_sandik/app/commons/send_vote_button.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/commons/circular_indicator.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class ElectionPhotoView extends StatelessWidget {
  final controller = Get.find<ElectionController>();

  ElectionPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    int tabBarStatus = 0;
    return GetBuilder<ElectionController>(
      builder: (controller) {
        bool isDistrictFull = controller.districtPhoto != null;
        bool isCouncilFull = controller.councilPhoto != null;
        bool isCityFull = controller.cityPhoto != null;
        bool isAllFull = isCityFull || isDistrictFull || isCouncilFull;
        return PopScope(
          onPopInvoked: (_) {
            controller.startTimer();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const AppBarTitle(text: LocalizationKeys.tutanakEkle),
              iconTheme: const IconThemeData(color: AppColors.appWhite),
            ),
            body: controller.isLoading
                ? const CircularIndicator()
                : DefaultTabController(
                    length: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonsTabBar(
                              onTap: (value) {
                                tabBarStatus = value;
                                controller.update();
                              },
                              contentPadding: const EdgeInsets.all(0),
                              elevation: 4,
                              radius: 2,
                              backgroundColor: Colors.red.shade500,
                              unselectedBackgroundColor: Colors.grey.shade500,
                              tabs: [
                                Tab(
                                  child: PhotoTabBar(
                                    text: LocalizationKeys.iskenderun
                                        .toUpperCase(),
                                    type: VoteType.district.value,
                                    isIconActive: isDistrictFull,
                                    isSelected: tabBarStatus == 0,
                                  ),
                                ),
                                Tab(
                                  child: PhotoTabBar(
                                    text: LocalizationKeys.meclis.toUpperCase(),
                                    type: VoteType.council.value,
                                    isIconActive: isCouncilFull,
                                    isSelected: tabBarStatus == 1,
                                  ),
                                ),
                                Tab(
                                  child: PhotoTabBar(
                                    text: LocalizationKeys.buyukSehir
                                        .toUpperCase(),
                                    type: VoteType.city.value,
                                    isIconActive: isCityFull,
                                    isSelected: tabBarStatus == 2,
                                  ),
                                ),
                              ],
                            ),
                            isAllFull || controller.isExistPhotosOnApi()
                                ? SingleChildScrollView(
                                    controller: ScrollController(),
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: buildPictures(context),
                                    ),
                                  )
                                : buildTextInfo(),
                            buildButtons(
                              isAllFull,
                              context,
                              tabBarStatus,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Row buildPictures(BuildContext context) {
    return Row(
      children: [
        controller.districtPhoto != null
            ? buildPhoto(context, controller.districtPhoto!)
            : isExistPhotoOnApi(context, VoteType.district.value),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: controller.councilPhoto != null
              ? buildPhoto(context, controller.councilPhoto!)
              : isExistPhotoOnApi(context, VoteType.council.value),
        ),
        controller.cityPhoto != null
            ? buildPhoto(context, controller.cityPhoto!)
            : isExistPhotoOnApi(context, VoteType.city.value),
      ],
    );
  }

  Widget isExistPhotoOnApi(BuildContext context, String type) {
    final box = controller.linkedBallotBox.getBoxType(type);
    return box.reportImage != null
        ? InstaImageViewer(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: AppMediaQuery.height(0.20, context),
              width: AppMediaQuery.width(0.30, context),
              imageUrl: "${AppConstants.baseUrl}/${box.reportImage}",
            ),
          )
        : const SizedBox();
  }

  Column buildButtons(
    isAllFull,
    BuildContext context,
    int tabBarStatus,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                onPressed: () => controller.pickImageFromCameraOrGallery(
                    ImageSource.camera, tabBarStatus),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(25.0),
                shape: const CircleBorder(),
                child: Icon(
                  FontAwesomeIcons.camera,
                  size: 35.0,
                  color: Colors.blueAccent.shade400,
                ),
              ),
              RawMaterialButton(
                onPressed: () => controller.pickImageFromCameraOrGallery(
                    ImageSource.gallery, tabBarStatus),
                elevation: 3,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(25.0),
                shape: const CircleBorder(),
                child: Icon(
                  FontAwesomeIcons.image,
                  size: 35.0,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
        ),
        isAllFull
            ? SizedBox(
                child: SendVoteButton(
                  mainAxisSize: MainAxisSize.max,
                  text: LocalizationKeys.kesinSonuclariGonder.toUpperCase(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppAlertDialog(
                          contentText: LocalizationKeys.alertTutanakGonderme,
                          onPressed: () {
                            Navigator.pop(context);
                            controller.sendReportImage();
                          },
                        );
                      },
                    );
                  },
                  stadiumBorder: const StadiumBorder(),
                  icon: FontAwesomeIcons.locationArrow,
                  isWidget: true,
                  size: 15,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Padding buildTextInfo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      child: Text(
        textAlign: TextAlign.center,
        LocalizationKeys.tutanakBilgiMesaj,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  InstaImageViewer buildPhoto(BuildContext context, File file) {
    return InstaImageViewer(
      child: Image.file(
        file,
        fit: BoxFit.cover,
        height: AppMediaQuery.height(0.2, context),
        width: AppMediaQuery.width(0.3, context),
      ),
    );
  }
}
