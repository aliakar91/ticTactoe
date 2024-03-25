import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:ak_sandik/app/modules/election_module/election_photo_view.dart';
import 'package:ak_sandik/app/modules/election_module/widgets/candidate_list_widget.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/commons/app_bar_title.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ak_sandik/app/commons/app_alert_dialog.dart';
import 'package:ak_sandik/app/commons/send_vote_button.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/commons/circular_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/data/enums/ballot_box_status.dart';
import 'package:vertical_scroll_tabbar/vertical_scroll_tabbar.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

//ignore: must_be_immutable
class ElectionView extends StatelessWidget {
  int tabBarValue = 0;
  final ballotBox = Get.arguments as BallotBox;
  final controller = Get.find<ElectionController>();

  ElectionView({super.key}) {
    controller.createBallotBox(ballotBox.id, ballotBox.status);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GetBuilder<ElectionController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: AppBarTitle(
              text: "${LocalizationKeys.sandik} No: ${ballotBox.no}  ",
            ),
            iconTheme: const IconThemeData(color: AppColors.appWhite),
          ),
          body: controller.isLoading
              ? const CircularIndicator()
              : Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: !isReportImages() ? 50.0 : 0.0,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SafeArea(
                          child: VerticalScrollTabbar(
                            onTabChange: (value) {
                              tabBarValue = value;
                              controller.update();
                            },
                            indicatorColor: AppColors.primary,
                            tabs: [
                              buildTabBar(
                                LocalizationKeys.district,
                                LocalizationKeys.iskenderun.toUpperCase(),
                                0,
                              ),
                              buildTabBar(
                                LocalizationKeys.council,
                                LocalizationKeys.meclis.toUpperCase(),
                                1,
                              ),
                              buildTabBar(
                                LocalizationKeys.city,
                                LocalizationKeys.buyukSehir.toUpperCase(),
                                2,
                              ),
                            ],
                            children: [
                              buildCandidateList(
                                LocalizationKeys.district,
                                VoteType.district.value,
                              ),
                              buildCandidateList(
                                LocalizationKeys.council,
                                VoteType.council.value,
                              ),
                              buildCandidateList(
                                LocalizationKeys.city,
                                VoteType.city.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    !isReportImages()
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: SendVoteButton(
                              mainAxisSize: MainAxisSize.min,
                              text: LocalizationKeys.kesinSonuclariGonder
                                  .toUpperCase(),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AppAlertDialog(
                                      contentText:
                                          LocalizationKeys.alertOyGonderme,
                                      onPressed: () {
                                        controller.sendElectionResults();
                                        Navigator.of(context).pop();
                                        Get.to(() => ElectionPhotoView());
                                        controller.stopTimer();
                                      },
                                    );
                                  },
                                );
                              },
                              stadiumBorder: const StadiumBorder(),
                              size: 14,
                              isWidget: true,
                              icon: FontAwesomeIcons.share,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
        );
      },
    );
  }

  Column buildCandidateList(String label, String type) {
    return Column(
      key: GlobalKey(debugLabel: label),
      children: [
        CandidateListWidget(
          ballotBox: ballotBox,
          type: type,
        ),
      ],
    );
  }

  Tab buildTabBar(String label, String text, int value) {
    return Tab(
      key: GlobalKey(debugLabel: label),
      child: SizedBox(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: tabBarValue == value ? AppColors.primary : Colors.black,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  bool isReportImages() {
    return (controller.linkedBallotBox
                    .getBoxType(VoteType.city.value)
                    .reportImage !=
                null &&
            controller.linkedBallotBox
                    .getBoxType(VoteType.district.value)
                    .reportImage !=
                null &&
            controller.linkedBallotBox
                    .getBoxType(VoteType.council.value)
                    .reportImage !=
                null) &&
        (controller.linkedBallotBox.status == Status.three.value);
  }
}
