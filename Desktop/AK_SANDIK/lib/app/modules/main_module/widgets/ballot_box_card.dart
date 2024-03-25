import 'package:ak_sandik/app/globals/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/data/enums/ballot_box_status.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

//ignore: must_be_immutable
class BallotBoxCard extends StatelessWidget {
  BallotBox ballotBox;

  BallotBoxCard({required this.ballotBox, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.appWhite,
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          FontAwesomeIcons.box,
                          size: 45,
                          color: ballotBox.status == Status.three.value
                              ? Colors.red.shade600
                              : AppColors.blueGreyShade700,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "${LocalizationKeys.sandik}: ",
                                style: TextStyle(fontSize: 22.5),
                              ),
                              Text(
                                ballotBox.no,
                                style: AppTextStyle.ballotBoxNo(),
                              ),
                            ],
                          ),
                          Text(
                            // "${ballotBox.district.name} / ${ballotBox.city.name}",
                            ballotBox.city.name.toUpperCase(),
                            style: AppTextStyle.cityNameStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ballotBox.status == Status.three.value
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Tamamlandı!",
                                style: AppTextStyle.ballotBoxHasDone(),
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.circleCheck,
                              size: 26,
                              color: Colors.green.shade700,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
