import 'package:party_proje_deneme/app/data/models/candidate.dart';

class Box {
  String id;
  int sandikNo;
  int secmenSayisi;
  int gecerliOy;
  int gecersizOy;
  int sayilanOy;
  int kullanilmayanOy;
  String cityName;
  String districtName;
  List<Candidate> candidate;

  Box({
    required this.id,
    required this.sandikNo,
    required this.secmenSayisi,
    required this.gecerliOy,
    required this.gecersizOy,
    required this.sayilanOy,
    required this.kullanilmayanOy,
    required this.cityName,
    required this.districtName,
    required this.candidate,
  });

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"],
        sandikNo: json["sandik_no"],
        secmenSayisi: json["secmen_sayisi"],
        gecerliOy: json["gecerli_oy"],
        gecersizOy: json["gecersiz_oy"],
        sayilanOy: json["sayilan_oy"],
        kullanilmayanOy: json["kullanilmayan_oy"],
        cityName: json["city_name"],
        districtName: json["district_name"],
        candidate: json["candidate"].map<Candidate>((json) => Candidate.fromJson(json)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sandik_no": sandikNo,
        "secmen_sayisi": secmenSayisi,
        "gecerli_oy": gecerliOy,
        "gecersiz_oy": gecersizOy,
        "sayilan_oy": sayilanOy,
        "kullanilmayan_oy": kullanilmayanOy,
        "city_name": cityName,
        "district_name": districtName,
        "candidate": candidate.map((e) => e.toJson()).toList(),
      };
}
