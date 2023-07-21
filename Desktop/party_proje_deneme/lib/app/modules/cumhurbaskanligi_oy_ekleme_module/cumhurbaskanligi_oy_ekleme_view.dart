import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:party_proje_deneme/app/commons/alert_dialog.dart';
import 'package:party_proje_deneme/app/data/models/kisiler_sandik.dart';
import 'package:party_proje_deneme/app/globals/constants/constants.dart';
import 'package:party_proje_deneme/app/commons/sandik_sayi_bilgileri.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/commons/cumhurbaskanligi_oy_ekleme_card_widget_last.dart';
import 'package:party_proje_deneme/app/commons/cumhurbaskani_adaylari_oy_ekleme_card_widget.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_tutanak_ekleme_view.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme_controller.dart';

class CumhurbaskanligiOyEklemeSayfasi extends StatelessWidget {
  late final CumhurbaskanligiOyEklemeController cumhurbaskanligiController;
  final sandiklarimController = Get.put(SandiklarimController());
  final KisilerSandik cumhurbaskanlariSandik;

  CumhurbaskanligiOyEklemeSayfasi({required this.cumhurbaskanlariSandik, Key? key}) : super(key: key) {
    cumhurbaskanligiController = Get.put(
      CumhurbaskanligiOyEklemeController(),
      tag: cumhurbaskanlariSandik.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CumhurbaskanligiOyEklemeController>(
      tag: cumhurbaskanlariSandik.id,
      builder: (cumhurbaskanligiController) {
        cumhurbaskanligiController.addInvalidAndEmptyVoteList(cumhurbaskanlariSandik);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Cumhurbaşkanlığı"),
            leading: BackButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SandiklarimView()));
                //Get.offAll(() => SandiklarimView());
                // var box = GetStorage();
                // box.read(SharedPrefKey.sharedPrefVoteSaveKey) ??
                //     CumhurbaskanligiOyEklemeController()
                //         .cumhurbaskaniAdaylarList;
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
                        onPressed: () {
                          for (int i = 0; i < cumhurbaskanligiController.cumhurbaskaniAdaylarList.length; i++) {
                            cumhurbaskanligiController.cumhurbaskaniAdaylarList[i].vote = 0;
                            cumhurbaskanligiController.cumhurbaskaniAdaylarList[i].invalidVote = 0;
                            cumhurbaskanligiController.extraListItems[i].emptyVote = 0;
                            cumhurbaskanligiController.extraListItems[i].invalidVote = 0;
                          }
                          cumhurbaskanlariSandik.invalidVote = 0.toString();
                          cumhurbaskanlariSandik.voted = 0.toString();
                          cumhurbaskanlariSandik.emptyVote = 0.toString();
                          cumhurbaskanligiController.update();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                  //sandiklarimController.update();
                },
                icon: const Icon(
                  FontAwesomeIcons.rotateRight,
                  size: 20,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SandikSayiBilgileri(
                          sandikNo: cumhurbaskanlariSandik.no,
                          sehirIsmi: "${cumhurbaskanlariSandik.districtName}/${cumhurbaskanlariSandik.cityName}",
                          secmenSayisi: cumhurbaskanlariSandik.totalVote,
                          sayilanOy: (int.parse(cumhurbaskanlariSandik.voted) +
                                  int.parse(cumhurbaskanlariSandik.invalidVote) +
                                  (int.parse(cumhurbaskanlariSandik.emptyVote)))
                              .toString(),
                          gecerliOy: (int.parse(cumhurbaskanlariSandik.voted)).toString(),
                          gecersizOy: cumhurbaskanlariSandik.invalidVote,
                          kullanilmayanOy: cumhurbaskanlariSandik.emptyVote,
                        ),
                        Obx(
                          () => Container(
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
                                      return cumhurbaskanligiController.cumhurbaskaniAdaylarList[index].image == ""
                                          ? const SizedBox()
                                          : Column(
                                              children: [
                                                CumhurbaskaniAdaylarOyEklemeCardWidget(
                                                  candidate: cumhurbaskanligiController.cumhurbaskaniAdaylarList[index],
                                                  kisilerSandik: cumhurbaskanlariSandik,
                                                  isInvalid: false,
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cumhurbaskanligiController.cumhurbaskaniAdaylarList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CumhurbaskaniAdaylarOyEklemeCardWidget(
                                            kisilerSandik: cumhurbaskanlariSandik,
                                            candidate: cumhurbaskanligiController.cumhurbaskaniAdaylarList[index],
                                            isInvalid: true,
                                            isEmptyVote: false,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CumhurbaskanligiOyEklemeLastCardWidget(
                                            kisilerSandik: cumhurbaskanlariSandik,
                                            candidate: cumhurbaskanligiController.extraListItems[index],
                                            isInvalid: true,
                                            isEmptyVote: index == 1,
                                            text: cumhurbaskanligiController.extraListItems[index].name,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                AppButton(
                  text: " Kesin Sonuçları Gönder",
                  onPressed: () {
                    cumhurbaskanligiController.candidateAddVote();
                    print("Liste  ${cumhurbaskanligiController.candidateWithVoteList}");
                    Get.offAll(
                      () => CumhurbaskanligiTutanakEklemeView(
                        votesData: SendVoteForPresidency(
                            ballotBoxId: int.parse(cumhurbaskanlariSandik.id),
                            emptyVotes: int.parse(cumhurbaskanlariSandik.emptyVote),
                            invalidVotes: int.parse(cumhurbaskanlariSandik.invalidVote),
                            candidatesWithVotes: cumhurbaskanligiController.candidateWithVoteList),
                      ),
                    );
                    // cumhurbaskanligiController.cumhurbaskanligiOyEkleme(SendVoteForPresidency(
                    //     ballotBoxId: int.parse(cumhurbaskanlariSandik.id),
                    //     emptyVotes: int.parse(cumhurbaskanlariSandik.emptyVote),
                    //     invalidVotes: int.parse(cumhurbaskanlariSandik.invalidVote),
                    //     candidatesWithVotes: cumhurbaskanligiController.candidateWithVoteList),);
                  },
                  stadiumBorder: const StadiumBorder(),
                  size: 22,
                  isWidget: true,
                  icon: FontAwesomeIcons.check,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
