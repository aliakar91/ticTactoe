import 'package:ak_sandik/app/data/enums/vote_type.dart';
import 'package:ak_sandik/app/data/models/box.dart';

class BallotBox {
  String id;
  String no;
  int totalVote;
  String status;
  City city;
  District district;

  BallotBox({
    required this.id,
    required this.no,
    required this.totalVote,
    required this.status,
    required this.city,
    required this.district,
  });

  factory BallotBox.fromJson(Map<String, dynamic> json) {
    return BallotBox(
      id: json['id'] ?? "0",
      no: json['no'],
      totalVote: int.tryParse("${json['total_vote']}") ?? 0,
      status: json['status'] ?? "0",
      city: City.fromJson(json['city']),
      district: District.fromJson(json['district']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'total_vote': totalVote,
        'status': status,
        'city': city.toJson(),
        'district': district.toJson(),
      };
}

class LinkedBallotBox extends BallotBox {
  Box districtBox;
  Box councilBox;
  Box cityBox;
  User user;
  DateTime? dateTime;

  LinkedBallotBox({
    required String id,
    required String no,
    required int totalVote,
    required dynamic status,
    required City city,
    required District district,
    required this.user,
    required this.districtBox,
    required this.councilBox,
    required this.cityBox,
  }) : super(
          id: id,
          no: no,
          totalVote: totalVote,
          status: status,
          city: city,
          district: district,
        );

  factory LinkedBallotBox.fromJson(Map<String, dynamic> json) {
    return LinkedBallotBox(
      id: json['id'],
      no: json['no'],
      totalVote: int.tryParse("${json['total_vote']}") ?? 0,
      status: json['status'].toString(),
      city: City.fromJson(json['city']),
      district: District.fromJson(json['district']),
      user: User.fromJson(json['user']),
      cityBox: Box.fromJson(json['city_box']),
      districtBox: Box.fromJson(json['district_box']),
      councilBox: Box.fromJson(json['council_box']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'total_vote': totalVote,
        'status': status.toString(),
        'city': city.toJson(),
        'district': district.toJson(),
        'user': user.toJson(),
        'city_box': cityBox.toJson(),
        'district_box': districtBox.toJson(),
        'council_box': councilBox.toJson(),
      };

  Box getBoxType(String type) {
    if (type == VoteType.city.value) {
      return cityBox;
    } else if (type == VoteType.district.value) {
      return districtBox;
    } else {
      return councilBox;
    }
  }

  String? getReportImage(String type) {
    if (type == VoteType.city.value) {
      return cityBox.reportImage;
    } else if (type == VoteType.district.value) {
      return districtBox.reportImage;
    } else {
      return councilBox.reportImage;
    }
  }

  @override
  String toString() {
    return 'BallotBox{id: $id, no: $no, totalVote: $totalVote, status: $status,'
        'city: ${city.name}, district: ${district.name} \n '
        'LinkedBallotBox{districtBox: $districtBox, councilBox: $councilBox}'
        '\n districtBox: ${districtBox.voted}, council_box: $councilBox ,'
        'city_box:$cityBox';
  }
}

class City {
  String id;
  String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class District {
  String id;
  String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class User {
  String id;
  String fullName;
  String? phoneNumber;

  User({
    required this.id,
    required this.fullName,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      fullName: json["full_name"],
      phoneNumber: json["phone_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}
