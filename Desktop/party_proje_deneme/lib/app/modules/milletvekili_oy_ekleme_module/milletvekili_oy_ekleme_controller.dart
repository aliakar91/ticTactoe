import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_proje_deneme/app/commons/toast_message.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/repositories/milletvekilligi_oy_ekleme_repository.dart';

class MilletvekiliOyEklemeController extends GetxController {
  File? photo;
  final milletvekilligiOyEklemeRepository = MilletvekilligiOyEklemeRepository();

  final _milletvekilleriAdaylarList = <Candidate>[].obs;

  List<Candidate> get milletvekilleriAdaylarList => _milletvekilleriAdaylarList;

  set milletvekilleriAdaylarList(value) =>
      _milletvekilleriAdaylarList.value = value;

  @override
  void onReady() async {
    await milletvekilleriAdaylari(2);
    super.onReady();
  }

  Future<void> milletvekilleriAdaylari(int type) async {
    milletvekilleriAdaylarList =
        await milletvekilligiOyEklemeRepository.milletvekilleriAdaylari(type);
  }

  Future pickImageFromCameraOrGallery(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      photo = imageTemporary;
    } catch (e) {
      LoginShowToastMessage.showToastMessage(
        "HATA OLUŞTU",
        color: Colors.red,
      );
    }
    update();
  }

}
