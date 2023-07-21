class CumhurbaskanlikAdaylariOySayilari {
  String id;
  int secmenSayisi;
  int gecerliOy;
  int gecersizOy;
  int kullanilmayanOy;
  int sayilanOy;

  CumhurbaskanlikAdaylariOySayilari({
    required this.id,
    required this.secmenSayisi,
    required this.gecerliOy,
    required this.gecersizOy,
    required this.kullanilmayanOy,
    required this.sayilanOy,
  });

  factory CumhurbaskanlikAdaylariOySayilari.fromJson(
          Map<String, dynamic> json) =>
      CumhurbaskanlikAdaylariOySayilari(
        id: json["id"],
        secmenSayisi: json["secmenSayisi"],
        gecerliOy: json["gecerliOy"],
        gecersizOy: json["gecersizOy"],
        kullanilmayanOy: json["kullanilmayanOy"],
        sayilanOy: json["sayilanOy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "secmenSayisi": secmenSayisi,
        "gecerliOy": gecerliOy,
        "gecersizOy": gecersizOy,
        "kullanilmayanOy": kullanilmayanOy,
        "sayilanOy": sayilanOy,
      };
}
