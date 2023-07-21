import 'package:get/get.dart';
import 'package:party_proje_deneme/app/globals/styles/app_colors.dart';
import 'sonuclar_sayfasi.dart';
import 'package:flutter/material.dart';
import 'sonuclar_sayfasi_controller.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';
import 'package:party_proje_deneme/app/globals/styles/app_text_styles.dart';
import 'package:party_proje_deneme/app/commons/adaylar_sonuclar_card_widget.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme_controller.dart';

class SonuclarSayfasiView extends StatelessWidget {
  SonuclarSayfasiView({Key? key}) : super(key: key);
  final controller = Get.put(SonuclarSayfasiController());
  final cumhurbaskanligiController =
      Get.put(CumhurbaskanligiOyEklemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SandiklarimView()));
          },
        ),
        title: const Text("Sonuçlar"),
      ),
      body: Obx(
        () => Card(
          color: Colors.white,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      width: 163,
                      onPressed: () {
                        controller.candidateType = !controller.candidateType;
                      },
                      text: controller.candidateType
                          ? "Cumhurbaşkanlığı"
                          : "Milletvekili",
                      size: 16,
                    ),
                    AppButton(
                      width: 163,
                      onPressed: () {
                        if (controller.resultButtonName == Region.turkiye) {
                          controller.resultButtonName = Region.country;
                        } else if (controller.resultButtonName ==
                            Region.country) {
                          controller.resultButtonName = Region.district;
                        } else {
                          controller.resultButtonName = Region.turkiye;
                        }
                      },
                      color: Colors.green.shade700,
                      text: controller.resultButtonName == Region.turkiye
                          ? "Türkiye Geneli"
                          : controller.resultButtonName == Region.country
                              ? "İl Geneli "
                              : "İlçe Geneli ",
                      size: 16,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.candidateType
                          ? "Cumhurbaşkanlığı"
                          : "Milletvekili",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        controller.resultButtonName == Region.turkiye
                            ? "Türkiye Geneli Sonuçlar"
                            : controller.resultButtonName == Region.country
                                ? "İl Geneli Sonuçlar"
                                : "İlçe Geneli Sonuçlar",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Açılan Sandık",
                        style: AppTextStyle.boxText,
                      ),
                      Text(
                        "Kapalı Sandık",
                        style: AppTextStyle.boxText,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "3453",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        "2222",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 35,
                    animation: true,
                    lineHeight: 25,
                    animationDuration: 2000,
                    percent: 0.9,
                    center: const Text("90.0%"),
                    progressColor: Colors.blue,
                    backgroundColor: Colors.brown.shade300,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.candidateType
                          ? cumhurbaskanligiController.adaylar.length
                          : controller.milletvekilleriPartyListesi.length,
                      itemBuilder: (context, index) {
                        return AdaylarSonuclarCardWidget(
                          candidate: controller.candidateType
                              ? cumhurbaskanligiController.adaylar[index]
                              : controller.milletvekilleriPartyListesi[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
