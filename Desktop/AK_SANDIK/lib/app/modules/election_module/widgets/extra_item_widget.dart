import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/commons/app_divider.dart';
import 'package:ak_sandik/app/commons/vote_button.dart';
import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ak_sandik/app/data/enums/ballot_box_status.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class ExtraItemWidget extends StatelessWidget {
  final int vote;
  final int? index;
  final String text;
  final String type;
  final bool isInvalid;
  final bool isParty;
  final controller = Get.find<ElectionController>();
  final TextEditingController textEditingController = TextEditingController();

  ExtraItemWidget({
    required this.text,
    this.index,
    required this.vote,
    required this.type,
    this.isParty = false,
    this.isInvalid = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final linkedBallotBox = controller.linkedBallotBox;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5.sp,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    linkedBallotBox.status == Status.three.value
                        ? const SizedBox()
                        : VoteButton(
                            onPressed: () => setVote(-1),
                            icon: FontAwesomeIcons.minus,
                            fillColor: Colors.red.shade700,
                          ),
                    linkedBallotBox.status == Status.three.value
                        ? Text(
                            vote.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.sp,
                            ),
                          )
                        : buildGestureDetector(context, linkedBallotBox),
                    linkedBallotBox.status == Status.three.value
                        ? const SizedBox()
                        : VoteButton(
                            onPressed: () => setVote(1),
                            icon: FontAwesomeIcons.plus,
                            fillColor: Colors.green.shade700,
                          ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: AppDivider(),
          ),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      BuildContext context, LinkedBallotBox linkedBallotBox) {
    return GestureDetector(
      onTap: () => gestureOnTap(context),
      child: Column(
        children: [
          Text(
            vote.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.sp,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  setVote(int number) {
    final box = controller.linkedBallotBox.getBoxType(type);
    if (isParty) {
      controller.setPartyInvalidVote(
        type,
        box.candidates[index!].invalidVote + number,
        index!,
      );
    } else {
      controller.setInvalidVote(
        type,
        isInvalid
            ? box.invalidVote + number
            : box.emptyVote + number,
        isInvalid,
      );
    }
  }

  arrangeInputVote(BuildContext context) {
    if (isParty) {
      controller.setPartyInvalidVote(
        type,
        int.parse(textEditingController.text),
        index!,
      );
    } else {
      controller.setInvalidVote(
        type,
        int.parse(textEditingController.text),
        isInvalid,
      );
    }
    Navigator.of(context).pop();
    controller.update();
  }

  gestureOnTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(LocalizationKeys.duzenle),
          content: TextFormField(
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
              onPressed: () => arrangeInputVote(context),
              child: const Text(LocalizationKeys.guncelle),
            ),
          ],
        );
      },
    );
    textEditingController.text = vote.toString();
  }
}
