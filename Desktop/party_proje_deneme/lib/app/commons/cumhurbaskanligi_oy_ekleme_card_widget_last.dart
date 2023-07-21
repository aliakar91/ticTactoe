import 'package:get/get.dart';
import 'raw_material_app_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/styles/app_text_styles.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme_controller.dart';

class CumhurbaskanligiOyEklemeLastCardWidget extends StatelessWidget {
  final Candidate candidate;
  final String text;
  final bool isInvalid;
  final bool isEmptyVote;
  final KisilerSandik kisilerSandik;
  late final CumhurbaskanligiOyEklemeController controller;
  final TextEditingController cumhurbaskaniOySayisiTextEditingController = TextEditingController();

  CumhurbaskanligiOyEklemeLastCardWidget({
    required this.text,
    required this.kisilerSandik,
    required this.isInvalid,
    required this.isEmptyVote,
    required this.candidate,
    Key? key,
  }) : super(key: key) {
    controller = Get.find<CumhurbaskanligiOyEklemeController>(tag: kisilerSandik.id);
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
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    text,
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
                  Column(
                    children: [
                      Text(
                        isInvalid ? candidate.invalidVote.toString() : candidate.vote.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 29,
                        ),
                      ),
                    ],
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
                                controller: cumhurbaskaniOySayisiTextEditingController,
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
                                      int.parse(cumhurbaskaniOySayisiTextEditingController.text),
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
