import 'package:ak_sandik/app/data/models/candidate.dart';

class Box {
  String id;
  int voted;
  int emptyVote;
  int invalidVote;
  String? reportImage;
  int type;
  List<Candidate> candidates;

  Box({
    required this.id,
    required this.voted,
    required this.emptyVote,
    required this.invalidVote,
    this.reportImage,
    required this.type,
    required this.candidates,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'],
      voted: int.tryParse("${json['voted']}") ?? 0,
      emptyVote: int.tryParse("${json['empty_vote']}") ?? 0,
      invalidVote: int.tryParse("${json['invalid_vote']}") ?? 0,
      reportImage: json['report_image'],
      type: json['type'],
      candidates: json["candidates"]
          .map<Candidate>((json) => Candidate.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'voted': voted,
        'empty_vote': emptyVote,
        'invalid_vote': invalidVote,
        'report_image': reportImage,
        'type': type,
        'candidates': candidates.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'BallotBox{id: $id, voted: $voted, emptyVote: $emptyVote,'
        ' invalidVote: $invalidVote, type: $type, candidate: $candidates';
  }
}
