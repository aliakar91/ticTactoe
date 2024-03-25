import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ak_sandik/app/commons/app_divider.dart';
import 'package:ak_sandik/app/commons/vote_button.dart';
import 'package:ak_sandik/app/data/models/candidate.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/data/enums/ballot_box_status.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class MayorCardWidget extends StatelessWidget {
  final controller = Get.find<ElectionController>();
  final String type;
  final Candidate candidate;
  final TextEditingController textEditingController = TextEditingController();

  MayorCardWidget({required this.type, required this.candidate, super.key});

  @override
  Widget build(BuildContext context) {
    LinkedBallotBox linkedBallotBox = controller.linkedBallotBox;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildPartyLogo(),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    linkedBallotBox.status == Status.three.value
                        ? const SizedBox()
                        : VoteButton(
                            onPressed: () {
                              controller.setVote(
                                type,
                                candidate,
                                candidate.vote - 1,
                              );
                            },
                            icon: FontAwesomeIcons.minus,
                            fillColor: Colors.red.shade700,
                          ),
                    linkedBallotBox.status == Status.three.value
                        ? Text(
                            candidate.vote.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.sp,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => gestureOnTap(context),
                            child: Column(
                              children: [
                                Text(
                                  candidate.vote.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocalizationKeys.duzenle,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.5.w),
                                      child: Icon(Icons.edit, size: 15.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    linkedBallotBox.status == Status.three.value
                        ? const SizedBox()
                        : VoteButton(
                            onPressed: () {
                              controller.setVote(
                                type,
                                candidate,
                                candidate.vote + 1,
                              );
                            },
                            icon: FontAwesomeIcons.plus,
                            fillColor: Colors.green.shade700,
                          ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 18),
            child: AppDivider(),
          ),
        ],
      ),
    );
  }

  Flexible buildPartyLogo() {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          candidate.party.id != "9999"
              ? Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      "assets/images/logo/${candidate.party.id}.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : const Center(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              candidate.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  gestureOnTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(LocalizationKeys.oySayisiniDuzenle),
          content: TextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration:
                const InputDecoration(hintText: LocalizationKeys.oyGiriniz),
            controller: textEditingController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(LocalizationKeys.iptal),
            ),
            TextButton(
              onPressed: () {
                controller.setVote(
                  type,
                  candidate,
                  int.parse(textEditingController.text),
                );
                Navigator.of(context).pop();
              },
              child: const Text(LocalizationKeys.guncelle),
            ),
          ],
        );
      },
    );
    textEditingController.text = candidate.vote.toString();
  }
}
