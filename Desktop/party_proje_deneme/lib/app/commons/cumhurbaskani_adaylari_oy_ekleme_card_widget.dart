import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/globals/styles/app_text_styles.dart';
import 'package:party_proje_deneme/app/commons/raw_material_app_button.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme_controller.dart';

class CumhurbaskaniAdaylarOyEklemeCardWidget extends StatelessWidget {
  final Candidate candidate;
  final bool isInvalid;
  final bool isEmptyVote;
  final KisilerSandik kisilerSandik;
  late final CumhurbaskanligiOyEklemeController controller;
  final TextEditingController cumhurbaskaniOySayisiTextEditingController =
      TextEditingController();
  final Function()? onDecrease;
  final Function()? onIncrease;
  final Function()? onArrange;
  final bool? isLast;

  CumhurbaskaniAdaylarOyEklemeCardWidget({
    required this.kisilerSandik,
    required this.isInvalid,
    required this.candidate,
    this.isEmptyVote = false,
    this.onDecrease,
    this.onIncrease,
    this.onArrange,
    this.isLast,
    Key? key,
  }) : super(key: key) {
    controller =
        Get.find<CumhurbaskanligiOyEklemeController>(tag: kisilerSandik.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: (candidate.image != "")
                      ? CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                              "${AppConstants.baseUrl}/${candidate.image}"),
                        )
                      : const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    candidate.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RawMaterialAppButton(
                onPressed: () {
                  controller.decreaseVoteNumber(
                    isInvalid,
                    candidate,
                    kisilerSandik,
                    isEmptyVote,
                  );
                },
                icon: FontAwesomeIcons.minus,
                fillColor: Colors.red.shade700,
              ),
              Column(
                children: [
                  Text(
                    isInvalid
                        ? candidate.invalidVote.toString()
                        : candidate.vote.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Düzenle"),
                              content: TextFormField(
                                controller:
                                    cumhurbaskaniOySayisiTextEditingController,
                                keyboardType: TextInputType.number,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("İptal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    int voteType = 0;
                                    if (isInvalid) {
                                      voteType = candidate.invalidVote!;
                                    } else {
                                      voteType = candidate.vote!;
                                    }
                                    controller.arrangeVoteNumber(
                                      int.parse(
                                          cumhurbaskaniOySayisiTextEditingController
                                              .text),
                                      voteType,
                                      isInvalid,
                                      kisilerSandik,
                                      candidate,
                                      isEmptyVote,
                                    );

                                    Navigator.of(context).pop();
                                    controller.update();
                                  },
                                  child: const Text("Güncelle"),
                                ),
                              ],
                            );
                          },
                        );
                        cumhurbaskaniOySayisiTextEditingController.text = "0";
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Düzenle",
                            style: AppTextStyle.voteAndVoterText,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.edit,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              RawMaterialAppButton(
                onPressed: () {
                  controller.increaseVoteNumber(
                    isInvalid,
                    kisilerSandik,
                    candidate,
                    isEmptyVote,
                  );
                  //increaseVoteNumber();
                  // box.write(kisilerSandik.no, Box);
                },
                icon: FontAwesomeIcons.plus,
                fillColor: Colors.green.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
