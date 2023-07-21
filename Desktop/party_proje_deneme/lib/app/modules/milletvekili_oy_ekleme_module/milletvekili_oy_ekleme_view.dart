import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:party_proje_deneme/app/commons/alert_dialog.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/commons/sandik_sayi_bilgileri.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/commons/milletvekilli_adaylari_oy_ekleme_card_widget.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme.dart';

class MilletvekiliOyEklemeView extends StatelessWidget {
  MilletvekiliOyEklemeView({required this.milletvekilleriSandik, Key? key})
      : super(key: key);
  final controller = Get.find<MilletvekiliOyEklemeController>();
  final sandiklarimController = Get.put(SandiklarimController());
  final KisilerSandik milletvekilleriSandik;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MilletvekiliOyEklemeController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Milletvekili"),
            leading: BackButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SandiklarimView()));
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppAlertDialog(
                        contentText:
                            "Oy sayımını sıfırlamak istediğine emin misin?",
                        confirmButtonText: "Tamam",
                        titleText: "Sıfırla",
                        onPressed: () {
                          for (int i = 0;
                              i < controller.milletvekilleriAdaylarList.length;
                              i++) {
                            controller.milletvekilleriAdaylarList[i].vote = 0;
                            controller
                                .milletvekilleriAdaylarList[i].invalidVote = 0;
                          }
                          milletvekilleriSandik.invalidVote = 0.toString();
                          milletvekilleriSandik.voted = 0.toString();
                          milletvekilleriSandik.emptyVote = 0.toString();
                          controller.update();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.rotateRight,
                  size: 20,
                ),
              ),
            ],
          ),
          body: GetBuilder(
            init: MilletvekiliOyEklemeController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SandikSayiBilgileri(
                              sandikNo: milletvekilleriSandik.no,
                              sehirIsmi:
                                  "${milletvekilleriSandik.districtName}/${milletvekilleriSandik.cityName}",
                              secmenSayisi: milletvekilleriSandik.totalVote,
                              sayilanOy: (int.parse(
                                          milletvekilleriSandik.voted) +
                                      int.parse(
                                          milletvekilleriSandik.invalidVote))
                                  .toString(),
                              gecerliOy:
                                  (int.parse(milletvekilleriSandik.voted))
                                      .toString(),
                              gecersizOy: milletvekilleriSandik.invalidVote,
                              kullanilmayanOy: milletvekilleriSandik.emptyVote,
                            ),
                            Container(
                              height: ListViewSize.listViewHeight(context),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .milletvekilleriAdaylarList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            MilletvekilleriOyEklemeCardWidget(
                                              kisilerSandik:
                                                  milletvekilleriSandik,
                                              isInvalid: false,
                                              candidate: controller
                                                      .milletvekilleriAdaylarList[
                                                  index],
                                              controller: controller,
                                            ),
                                            const Divider(
                                              thickness: 1,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .milletvekilleriAdaylarList.length,
                                      itemBuilder: (context, index) {
                                        return MilletvekilleriOyEklemeCardWidget(
                                          kisilerSandik: milletvekilleriSandik,
                                          isInvalid: true,
                                          candidate: controller
                                                  .milletvekilleriAdaylarList[
                                              index],
                                          controller: controller,
                                        );
                                      },
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppButton(
                      text: " Kesin Sonuçları Gönder",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     MilletvekiliTutanakEklemeView()));
                      },
                      stadiumBorder: const StadiumBorder(),
                      size: 22,
                      isWidget: true,
                      icon: FontAwesomeIcons.check,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
