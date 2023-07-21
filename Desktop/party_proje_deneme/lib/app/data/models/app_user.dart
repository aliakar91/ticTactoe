class AppUser {
  String id;
  String tcNo;

  AppUser({
    required this.id,
    required this.tcNo,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      tcNo: json['tc_no'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tc_no': tcNo,
      };
}
