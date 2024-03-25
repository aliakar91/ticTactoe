class Candidate {
  String id;
  String name;
  String? image;
  String type;
  int vote;
  Party party;
  int showInvalidVote;
  int invalidVote = 0;

  Candidate({
    required this.id,
    required this.name,
    this.image,
    required this.type,
    required this.vote,
    required this.party,
    required this.showInvalidVote,
    required this.invalidVote,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        vote: int.tryParse("${json['vote']}") ?? 0,
        party: json["party"] == null
            ? Party(id: '9999', name: 'Bağımsız Aday', shortName: 'B.A.',)
            : Party.fromJson(json["party"]),
        showInvalidVote: int.tryParse("${json['show_invalid_vote']}") ?? 0,
        invalidVote: json["invalid_vote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "type": type,
        "vote": vote,
        "party": party.toJson(),
        "show_invalid_vote": showInvalidVote,
        "invalid_vote": invalidVote,
      };

  @override
  String toString() {
    return 'BallotBox{id: $id, name: $name, image: $image, vote: $vote, '
        'type: $type, party: $party';
  }
}

class Party {
  String id;
  String name;
  String shortName;

  Party({
    required this.id,
    required this.name,
    required this.shortName,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
        id: json["id"],
        name: json["name"] ?? '',
        shortName: json["short_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
      };

  @override
  String toString() {
    return 'BallotBox{id: $id, name: $name, shortname: $shortName';
  }
}
