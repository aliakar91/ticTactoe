import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme_controller.dart';

class OylarKesinSonuclarCardWidget extends StatelessWidget {
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

  OylarKesinSonuclarCardWidget({
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Center(
                child: (candidate.image != "")
                    ? const CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          // "${AppConstants.baseUrl}/${candidate.image}",
                          "https://cdn1.ntv.com.tr/gorsel/GfyN5BBIu0O0G8r5KGQMug.jpg?width=1000&mode=crop&scale=both",
                        ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
