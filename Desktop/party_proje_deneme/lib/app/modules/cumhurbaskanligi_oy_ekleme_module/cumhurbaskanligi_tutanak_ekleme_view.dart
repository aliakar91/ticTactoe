import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'cumhurbaskanligi_sonuclar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_proje_deneme/app/commons/app_button.dart';
import 'package:party_proje_deneme/app/data/models/send_vote_for_presidency.dart';
import 'package:party_proje_deneme/app/modules/sandiklarim_module/sandiklarim.dart';
import 'package:party_proje_deneme/app/modules/cumhurbaskanligi_oy_ekleme_module/cumhurbaskanligi_oy_ekleme.dart';

class CumhurbaskanligiTutanakEklemeView extends StatefulWidget {
  final SendVoteForPresidency votesData;

  const CumhurbaskanligiTutanakEklemeView({required this.votesData, Key? key}) : super(key: key);

  @override
  State<CumhurbaskanligiTutanakEklemeView> createState() => _CumhurbaskanligiTutanakEklemeViewState();
}

class _CumhurbaskanligiTutanakEklemeViewState extends State<CumhurbaskanligiTutanakEklemeView> {
  final imagePicker = ImagePicker();
  final cumhurbaskanligiController = Get.put(CumhurbaskanligiOyEklemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CumhurbaskanligiOyEklemeController>(
      builder: (CumhurbaskanligiOyEklemeController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tutanak Ekle'),
            leading: BackButton(
              onPressed: () {
                Get.off(() => SandiklarimView());
                //Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cumhurbaskanligiController.photo != null
                      ? Image.file(
                    cumhurbaskanligiController.photo!,
                    width: 300,
                    height: 400,
                    fit: BoxFit.cover,
                  )
                      : const SizedBox(),
                  cumhurbaskanligiController.photo != null
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
                  cumhurbaskanligiController.photo == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 160,
                        child: AppButton(
                          text: "Fotoğraf Çek ",
                          onPressed: () {
                            //getImage();
                            cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.camera);
                            //cumhurbaskanligiController.getImage();
                          },
                          icon: FontAwesomeIcons.camera,
                          isWidget: true,
                        ),
                      ),
                      Container(
                        width: 160,
                        child: AppButton(
                          text: "Galeriden Ekle",
                          onPressed: () {

                            cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.gallery);

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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          text: "Fotoğraf Çek",
                          onPressed: () {
                            //getImage();
                            cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.camera);
                            //cumhurbaskanligiController.getImage();
                          },
                          icon: FontAwesomeIcons.camera,
                          isWidget: true,
                        ),
                        AppButton(
                          mainAxisSize: MainAxisSize.max,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          text: "Galeriden Ekle",
                          onPressed: () {
                            //getImage();
                            cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.gallery);
                            //cumhurbaskanligiController.getImage();
                          },
                          icon: FontAwesomeIcons.folderOpen,
                          isWidget: true,
                        ),
                        AppButton(
                          mainAxisSize: MainAxisSize.max,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          text: "Kesin Sonuçları Gönder",
                          onPressed: () {
                            cumhurbaskanligiController.candidateAddVote();
                            cumhurbaskanligiController.cumhurbaskanligiOyEkleme(widget.votesData);
                            // cumhurbaskanligiController
                            //     .cumhurbaskanligiFotografEkleme(widget.votesData.ballotBoxId,cumhurbaskanligiController.photo!);
                            print("Liste  ${cumhurbaskanligiController.candidateWithVoteList}");
                            print("ID:${widget.votesData.ballotBoxId}");
                            print("Photo:${cumhurbaskanligiController.photo}");
                            Get.offAll(() => CumhurbaskanligiSonuclar());
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
      },
    );
  }
}

/*

  Scaffold(
      appBar: AppBar(
        title: const Text('Tutanak Ekle'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Image.network(_image.toString()),
              cumhurbaskanligiController.photo != null
                  ? Image.file(
                cumhurbaskanligiController.photo!,
                      width: 300,
                      height: 400,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
              cumhurbaskanligiController.photo != null
                  ? const SizedBox()
                  : const Text(
                      "Lütfen tutanak fotoğrafını ekleyin...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              cumhurbaskanligiController.photo == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 160,
                          child: AppButton(
                            text: "Fotoğraf  Çek ",
                            onPressed: () {
                              //getImage();
                              cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.camera);
                              //cumhurbaskanligiController.getImage();
                            },
                            icon: FontAwesomeIcons.camera,
                            isWidget: true,
                          ),
                        ),
                        Container(
                          width: 160,
                          child: AppButton(
                            text: "Galeriden Ekle",
                            onPressed: () {
                              //getImage();
                              cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.gallery);
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
                              cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.camera);
                              //cumhurbaskanligiController.getImage();
                            },
                            icon: FontAwesomeIcons.camera,
                            isWidget: true,
                          ),
                          AppButton(
                            mainAxisSize: MainAxisSize.max,
                            width: MediaQuery.of(context).size.width * 0.6,
                            text: "Galeriden Yükle",
                            onPressed: () {
                              //getImage();
                              cumhurbaskanligiController.pickImageFromCameraOrGallery(ImageSource.gallery);
                              //cumhurbaskanligiController.getImage();
                            },
                            icon: FontAwesomeIcons.folderOpen,
                            isWidget: true,
                          ),
                          AppButton(
                            mainAxisSize: MainAxisSize.max,
                            width: MediaQuery.of(context).size.width * 0.6,
                            text: "Kesin Sonuçları Gönder",
                            onPressed: () {
                              Get.offAll( CumhurbaskanligiSonuclar());
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

   */

// Future pickImageFromCameraOrGallery(ImageSource source) async {
//   try {
//     final image = await ImagePicker().pickImage(source: source);
//     if (image == null) return;
//     final imageTemporary = File(image.path);
//     setState(() {
//       photo = imageTemporary;
//     });
//   } catch (e) {
//     LoginShowToastMessage.showToastMessage(
//       "HATA OLUŞTU",
//       color: Colors.red,
//     );
//   }
// }
