class KisilerSandik {
  String id;
  String no;
  String totalVote;
  String voted;
  String emptyVote;
  String invalidVote;
  String? reportImage;
  String status;
  String type;
  String districtId;
  String userId;
  String createdAt;
  String updatedAt;
  String districtName;
  String cityId;
  String cityName;

  KisilerSandik({
    required this.id,
    required this.no,
    required this.totalVote,
    required this.voted,
    required this.emptyVote,
    required this.invalidVote,
    this.reportImage,
    required this.status,
    required this.type,
    required this.districtId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.districtName,
    required this.cityId,
    required this.cityName,
  });

  factory KisilerSandik.fromJson(Map<String, dynamic> json) {
    return KisilerSandik(
      id: json['id'],
      no: json['no'],
      totalVote: json['total_vote'],
      voted: json['voted'],
      emptyVote: json['empty_vote'],
      invalidVote: json["invalid_vote"],
      reportImage: json['report_image'],
      status: json['status'],
      type: json['type'],
      districtId: json['district_id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      districtName: json['district_name'],
      cityId: json['city_id'],
      cityName: json['city_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'total_vote': totalVote,
        'voted': voted,
        'empty_vote': emptyVote,
        'invalid_vote': invalidVote,
        'report_image': reportImage,
        'status': status,
        'type': type,
        'district_id': districtId,
        'user_id': userId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'district_name': districtName,
        'city_id': cityId,
        'city_name': cityName,
      };
}
