import 'package:ak_sandik/app/commons/circular_indicator.dart';
import 'package:ak_sandik/app/globals/styles/app_text_styles.dart';
import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:ak_sandik/app/modules/election_module/widgets/ballot_box_info_widget.dart';
import 'package:ak_sandik/app/modules/election_module/widgets/candidate_card_widget.dart';
import 'package:ak_sandik/app/modules/election_module/widgets/extra_item_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/data/models/candidate.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/commons/app_media_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/globals/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class CandidateListWidget extends StatelessWidget {
  final BallotBox ballotBox;
  final String type;
  final controller = Get.find<ElectionController>();

  CandidateListWidget({
    super.key,
    required this.ballotBox,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final box = controller.linkedBallotBox.getBoxType(type);
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14.h, bottom: 8.w),
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                ),
                child: Text(
                  voteType(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.greyShade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: BallotBoxInfoWidget(
                ballotBox: ballotBox,
                type: type,
              ),
            ),
            Column(
                children: box.candidates.map((candidate) {
              return MayorCardWidget(type: type, candidate: candidate);
            }).toList()),
            Padding(
              padding: EdgeInsets.only(top: 14.h, bottom: 8.h),
              child: Text(
                LocalizationKeys.gecersizOylar,
                style: AppTextStyle.mayorContentHeader(),
              ),
            ),
            Column(
                children: box.candidates.asMap().entries.map((entry) {
              int index = entry.key;
              Candidate candidate = entry.value;
              if (candidate.showInvalidVote == 1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Image.asset(
                        "assets/images/header/1.png",
                        fit: BoxFit.cover,
                        width: 100.w,
                      ),
                    ),
                    ExtraItemWidget(
                      type: type,
                      text: "${candidate.party.shortName} "
                          "${LocalizationKeys.gecersizOy}",
                      isParty: true,
                      vote: candidate.invalidVote,
                      index: index,
                    ),
                  ],
                );
              }
              return const SizedBox();
            }).toList()),
            ExtraItemWidget(
              type: type,
              text: LocalizationKeys.digerGecersizOy,
              isInvalid: true,
              vote: box.invalidVote,
            ),
            ExtraItemWidget(
              type: type,
              text: LocalizationKeys.kullanilmayanOy,
              vote: box.emptyVote,
            ),
            box.reportImage != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          LocalizationKeys.tutanak,
                          style: AppTextStyle.mayorContentHeader(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 40.0.h, left: 10.w, right: 10.w),
                        child: SizedBox(
                          height: AppMediaQuery.height(0.33, context),
                          child: InstaImageViewer(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppConstants.baseUrl}/${box.reportImage}",
                              placeholder: (context, url) =>
                                  const CircularIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  String voteType() {
    return type == VoteType.city.value
        ? LocalizationKeys.buyukSehir
        : type == VoteType.district.value
            ? LocalizationKeys.iskenderun
            : LocalizationKeys.meclis;
  }
}
