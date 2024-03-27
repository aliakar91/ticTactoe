class AppUser {
  String? tcNo;
  String fullName;
  String? districtId;
  String? cityId;
  String? group;

  AppUser({
    this.tcNo,
    required this.fullName,
    this.districtId,
    this.cityId,
    this.group,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      tcNo: json['tc_no'],
      fullName: json['full_name'],
      districtId: json['district_id'],
      cityId: json['city_id'],
      group: json['group'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tc_no': tcNo,
        'full_name': fullName,
        'district_id': districtId,
        'city_id': cityId,
        'group': group,
      };
}
