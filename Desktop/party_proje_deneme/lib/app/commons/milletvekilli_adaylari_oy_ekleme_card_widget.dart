import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/globals/styles/app_text_styles.dart';
import 'package:party_proje_deneme/app/commons/raw_material_app_button.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme.dart';

class MilletvekilleriOyEklemeCardWidget extends StatelessWidget {
  final Candidate candidate;
  final MilletvekiliOyEklemeController controller;
  TextEditingController milletvekiliOySayisiTextEditingController =
      TextEditingController();
  final bool isInvalid;
  final KisilerSandik kisilerSandik;

  MilletvekilleriOyEklemeCardWidget({
    required this.kisilerSandik,
    required this.candidate,
    required this.isInvalid,
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                candidate.image != ""
                    ? CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            "${AppConstants.baseUrl}/${candidate.image}"),
                      )
                    : const SizedBox(),
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
                  if (!isInvalid && candidate.vote! > 0) {
                    candidate.vote = (candidate.vote! - 1);
                    kisilerSandik.voted =
                        (int.parse(kisilerSandik.voted) - 1).toString();
                  } else if (isInvalid && candidate.invalidVote! > 0) {
                    candidate.invalidVote = (candidate.invalidVote! - 1);
                    kisilerSandik.invalidVote =
                        (int.parse(kisilerSandik.invalidVote) - 1).toString();
                  } else {
                    return;
                  }
                  controller.update();
                },
                icon: FontAwesomeIcons.minus,
                fillColor: Colors.red.shade700,
              ),
              Column(
                children: [
                  Text(
                    isInvalid == true
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
                                    milletvekiliOySayisiTextEditingController,
                                keyboardType: TextInputType.number,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    int voteType = 0;
                                    if (isInvalid) {
                                      voteType = candidate.invalidVote!;
                                    } else {
                                      voteType = candidate.vote!;
                                    }
                                    arrangeVoteNumber(
                                        int.parse(
                                            milletvekiliOySayisiTextEditingController
                                                .text),
                                        voteType);
                                    controller.update();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("İptal",
                                      style: AppTextStyle.voteAndVoterNumber),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.update();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Güncelle"),
                                ),
                              ],
                            );
                          },
                        );
                        milletvekiliOySayisiTextEditingController.text = "0";
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
              RawMaterialButton(
                onPressed: () {
                  increaseVoteNumber();
                  controller.update();
                },
                shape: const CircleBorder(),
                fillColor: Colors.green.shade700,
                padding: const EdgeInsets.all(10.0),
                child: const Icon(
                  FontAwesomeIcons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  increaseVoteNumber() {
    int totalNumber = 0;
    for (int i = 0; i < controller.milletvekilleriAdaylarList.length; i++) {
      totalNumber = totalNumber +
          controller.milletvekilleriAdaylarList[i].vote!.toInt() +
          controller.milletvekilleriAdaylarList[i].invalidVote!.toInt();
    }
    if (isInvalid) {
      if (totalNumber < int.parse(kisilerSandik.totalVote)) {
        kisilerSandik.invalidVote =
            (int.parse(kisilerSandik.invalidVote) + 1).toString();
        candidate.invalidVote = (candidate.invalidVote! + 1);
      } else {
        return;
      }
    } else {
      if (totalNumber < int.parse(kisilerSandik.totalVote)) {
        candidate.vote = (candidate.vote! + 1);
        kisilerSandik.voted = (int.parse(kisilerSandik.voted) + 1).toString();
      } else {
        return;
      }
    }
    controller.update();
  }

  arrangeVoteNumber(int voteNumber, int voteType) {
    int totalNumber = 0;
    for (int i = 0; i < controller.milletvekilleriAdaylarList.length; i++) {
      totalNumber = totalNumber +
          controller.milletvekilleriAdaylarList[i].vote!.toInt() +
          controller.milletvekilleriAdaylarList[i].invalidVote!.toInt();
      controller.update();
    }
    totalNumber = totalNumber - voteType;
    if (isInvalid) {
      if (voteNumber > int.parse(kisilerSandik.totalVote)) {
        candidate.invalidVote =
            int.parse(kisilerSandik.totalVote) - totalNumber;
      } else {
        if (voteNumber > int.parse(kisilerSandik.totalVote) - totalNumber) {
          candidate.invalidVote =
              int.parse(kisilerSandik.totalVote) - totalNumber;
        } else {
          candidate.invalidVote = voteNumber;
        }
      }
      kisilerSandik.invalidVote = (int.parse(kisilerSandik.invalidVote) -
              voteType +
              candidate.invalidVote!)
          .toString();
    } else {
      if (voteNumber > int.parse(kisilerSandik.totalVote)) {
        candidate.vote = int.parse(kisilerSandik.totalVote) - totalNumber;
      } else {
        if (voteNumber > int.parse(kisilerSandik.totalVote) - totalNumber) {
          candidate.vote = int.parse(kisilerSandik.totalVote) - totalNumber;
        } else {
          candidate.vote = voteNumber;
        }
      }
      kisilerSandik.voted =
          (int.parse(kisilerSandik.voted) - voteType + candidate.vote!)
              .toString();
    }
    controller.update();
  }
}
