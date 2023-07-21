import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'cumhurbaskanligi_oy_ekleme_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/alert_dialog.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/commons/sandik_sayi_bilgileri.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/commons/oylar_kesin_sonuclar_card_widget.dart';

class CumhurbaskanligiSonuclar extends StatelessWidget {
  final cumhurbaskanligiController = Get.put(CumhurbaskanligiOyEklemeController());

  CumhurbaskanligiSonuclar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Cumhurbaşkanlığı"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SandiklarimView(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AppAlertDialog(
                    contentText: "Oy sayımını sıfırlamak istediğine emin misin?",
                    confirmButtonText: "Tamam",
                    titleText: "Sıfırla",
                    onPressed: () {},
                  );
                },
              );
              //sandiklarimController.update();
            },
            icon: const Icon(
              FontAwesomeIcons.superpowers,
              size: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SandikSayiBilgileri(
              sandikNo: "11",
              sehirIsmi: "Antalya",
              secmenSayisi: "12",
              sayilanOy: "13",
              gecerliOy: "14",
              gecersizOy: "15",
              kullanilmayanOy: "16",
            ),
            Container(
              height: ListViewSize.listViewHeight(context),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cumhurbaskanligiController.cumhurbaskaniAdaylarList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OylarKesinSonuclarCardWidget(
                              isInvalid: true,
                              isLast: true,
                              isEmptyVote: true,
                              candidate: Candidate(
                                id: "1",
                                type: "1",
                                image:
                                    "https://m0.her.ie/wp-content/uploads/2018/01/07093633/GettyImages-887815620.jpg",
                                name: "",
                                invalidVote: 2,
                                vote: 2,
                              ),
                              kisilerSandik: KisilerSandik(
                                invalidVote: "",
                                id: "",
                                voted: "",
                                totalVote: "",
                                status: "",
                                no: "",
                                emptyVote: "",
                                districtId: "",
                                cityName: "",
                                cityId: "",
                                createdAt: "",
                                updatedAt: "",
                                type: "",
                                userId: "",
                                districtName: "",
                                reportImage: "",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Geçersiz Oylar",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cumhurbaskanligiController.cumhurbaskaniAdaylarList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OylarKesinSonuclarCardWidget(
                              isInvalid: true,
                              isLast: true,
                              isEmptyVote: true,
                              candidate: Candidate(
                                id: "1",
                                type: "1",
                                image:
                                    "https://m0.her.ie/wp-content/uploads/2018/01/07093633/GettyImages-887815620.jpg",
                                name: "",
                                invalidVote: 2,
                                vote: 2,
                              ),
                              kisilerSandik: KisilerSandik(
                                invalidVote: "",
                                id: "",
                                voted: "",
                                totalVote: "",
                                status: "",
                                no: "",
                                emptyVote: "",
                                districtId: "",
                                cityName: "",
                                cityId: "",
                                createdAt: "",
                                updatedAt: "",
                                type: "",
                                userId: "",
                                districtName: "",
                                reportImage: "",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    cumhurbaskanligiController.photo != null
                        ? Image.file(
                            cumhurbaskanligiController.photo!,
                            width: 300,
                            height: 400,
                            fit: BoxFit.cover,
                          )
                        : Text("aaa"),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
