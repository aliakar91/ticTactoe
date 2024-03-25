import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/commons/app_divider.dart';
import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ak_sandik/app/globals/styles/app_text_styles.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class BallotBoxInfoWidget extends StatelessWidget {
  final controller = Get.find<ElectionController>();
  final BallotBox ballotBox;
  final String type;

  BallotBoxInfoWidget({
    required this.ballotBox,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = controller.linkedBallotBox.getBoxType(type);
    final invalidPartyVote = controller.calculatePartyInvalidVote(type);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type == VoteType.city.value
                        ? ballotBox.city.name.toUpperCase()
                        : "${ballotBox.district.name} / ${ballotBox.city.name.toUpperCase()}",
                    style: AppTextStyle.voteNumberStyle(fontSize: 16.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.h),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${ballotBox.totalVote} ",
                            style: AppTextStyle.voteNumberStyle(),
                          ),
                          TextSpan(
                            text: LocalizationKeys.secmenSayisi,
                            style: AppTextStyle.voteAndVoterText(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${controller.calculateTotalNumber(type)} ",
                          style: AppTextStyle.voteNumberStyle(),
                        ),
                        TextSpan(
                          text: LocalizationKeys.sayilanOy,
                          style: AppTextStyle.voteAndVoterText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${box.voted} ",
                          style: AppTextStyle.voteNumberStyle(),
                        ),
                        TextSpan(
                          text: LocalizationKeys.gecerliOy,
                          style: AppTextStyle.voteAndVoterText(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.h),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${box.invalidVote + invalidPartyVote} ",
                            style: AppTextStyle.voteNumberStyle(),
                          ),
                          TextSpan(
                            text: LocalizationKeys.gecersizOy,
                            style: AppTextStyle.voteAndVoterText(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${box.emptyVote} ",
                          style: AppTextStyle.voteNumberStyle(),
                        ),
                        TextSpan(
                          text: LocalizationKeys.kullanilmayanOy,
                          style: AppTextStyle.voteAndVoterText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: AppDivider(),
          ),
        ],
      ),
    );
  }
}
