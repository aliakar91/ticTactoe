import 'package:get/get.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';
import 'package:party_proje_deneme/app/data/enums/request_type.dart';

class SonuclarSayfasiController extends GetxController {
  final _resultButtonName = Region.turkiye.obs;

  set resultButtonName(value) => _resultButtonName.value = value;

  Region get resultButtonName => _resultButtonName.value;

  final _candidateType = false.obs;

  set candidateType(value) => _candidateType.value = value;

  bool get candidateType => _candidateType.value;

  final List<Candidate> milletvekilleriPartyListesi = [
    Candidate(
        image: 'https://logowik.com/content/uploads/images/458_akparti.jpg',
        name: 'Adalet ve Kalkınma Partisi',
        type: "125",
        id: "1"),
    Candidate(
        image:
            'https://upload.wikimedia.org/wikipedia/commons/9/99/MHP_logo_Turkey.png',
        name: 'Milliyetçi Hareket Partisi',
        type: "52",
        id: "1"),
    Candidate(
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Flag_of_the_Republican_People%27s_Party_%28Turkey%29.svg/800px-Flag_of_the_Republican_People%27s_Party_%28Turkey%29.svg.png',
        name: 'Cumhuriyet Halk Partisi',
        type: "12",
        id: "1"),
    Candidate(
        image:
            'https://halktv.com.tr/wp-content/uploads/2017/10/iyi-parti-logo-Turk-mavisi.jpg',
        name: 'İyi Parti',
        type: "3",
        id: "1"),
    Candidate(
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Saadet_Partisi_logo.svg/2085px-Saadet_Partisi_logo.svg.png',
        name: 'Saadet Partisi',
        type: "6",
        id: "1"),
    Candidate(
        image:
            'https://www.kocaelisiyaset.com/wp-content/uploads/2021/10/deva-partisi-ilce-yonetim-listeleri-aciklandi_c257a.jpg',
        name: 'Demokrasi ve Atılım Partisi',
        type: "45",
        id: "1"),
    Candidate(
        image:
            'https://upload.wikimedia.org/wikipedia/tr/1/18/Demokrat_Parti_2007.png',
        name: 'Demokrat Parti',
        type: "66",
        id: "1"),
    Candidate(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZm_bw6Xru_Ja31NiIGPFajKQ74RgRY_OIBUEZEb0PYw&s',
        name: 'Gelecek Partisi',
        type: "72",
        id: "1"),
    Candidate(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAQd3ktx5v22HT9y-KfvuDHsasmpk53FcsHHazqKOEm8vRkBDDCErYmn4SMzns7pzayx0&usqp=CAU',
        name: 'Memleket Partisi',
        type: "14",
        id: "1"),
  ].obs;
}
