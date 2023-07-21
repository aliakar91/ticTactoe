import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekili_oy_ekleme.dart';
import 'package:party_proje_deneme/app/modules/milletvekili_oy_ekleme_module/milletvekilligi_sonuclar.dart';

class MilletvekiliTutanakEklemeView extends StatefulWidget {
  const MilletvekiliTutanakEklemeView({Key? key}) : super(key: key);

  @override
  State<MilletvekiliTutanakEklemeView> createState() =>
      _MilletvekiliTutanakEklemeViewState();
}

class _MilletvekiliTutanakEklemeViewState
    extends State<MilletvekiliTutanakEklemeView> {
  final milletvekilligiController = Get.put(MilletvekiliOyEklemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MilletvekiliOyEklemeController>(
        builder: (MilletvekiliOyEklemeController) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tutanak Ekle'),
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                milletvekilligiController.photo != null
                    ? Image.file(
                        milletvekilligiController.photo!,
                        width: 300,
                        height: 400,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(),
                milletvekilligiController.photo != null
                    ? const SizedBox()
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.0),
                        child: Text(
                          "Lütfen tutanak fotoğrafını ekleyin...",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                milletvekilligiController.photo == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            child: AppButton(
                              text: "Fotoğraf Çek",
                              onPressed: () {
                                milletvekilligiController
                                    .pickImageFromCameraOrGallery(
                                        ImageSource.camera);
                              },
                              icon: FontAwesomeIcons.camera,
                              isWidget: true,
                            ),
                          ),
                          Container(
                            width: 160,
                            child: AppButton(
                              mainAxisSize: MainAxisSize.max,
                              width: MediaQuery.of(context).size.width * 0.6,
                              text: "Galeriden Ekle",
                              onPressed: () {
                                //getImage();
                                milletvekilligiController
                                    .pickImageFromCameraOrGallery(
                                        ImageSource.gallery);
                                //cumhurbaskanligiController.getImage();
                              },
                              icon: FontAwesomeIcons.folderOpen,
                              isWidget: true,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            AppButton(
                              mainAxisSize: MainAxisSize.max,
                              width: MediaQuery.of(context).size.width * 0.6,
                              text: "Fotoğraf Çek",
                              onPressed: () {
                                //getImage();
                                milletvekilligiController
                                    .pickImageFromCameraOrGallery(
                                        ImageSource.camera);
                                //cumhurbaskanligiController.getImage();
                              },
                              icon: FontAwesomeIcons.camera,
                              isWidget: true,
                            ),
                            AppButton(
                              mainAxisSize: MainAxisSize.max,
                              width: MediaQuery.of(context).size.width * 0.6,
                              text: "Galeriden Ekle",
                              onPressed: () {
                                milletvekilligiController
                                    .pickImageFromCameraOrGallery(
                                        ImageSource.gallery);
                              },
                              icon: FontAwesomeIcons.folderOpen,
                              isWidget: true,
                            ),
                            AppButton(
                              mainAxisSize: MainAxisSize.max,
                              width: MediaQuery.of(context).size.width * 0.6,
                              text: "Kesin Sonuçları Gönder",
                              onPressed: () {
                                Get.offAll(
                                    () => const MilletvekilligiSonuclar());
                              },
                              icon: FontAwesomeIcons.download,
                              isWidget: true,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
