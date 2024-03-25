class SendVoteMayors {
  int ballotBoxId;
  int type;
  int emptyVotes;
  int invalidVotes;
  List<Map<String, dynamic>> candidatesWithVotes;

  SendVoteMayors({
    required this.ballotBoxId,
    required this.type,
    required this.emptyVotes,
    required this.invalidVotes,
    required this.candidatesWithVotes,
  });

  factory SendVoteMayors.fromJson(Map<String, dynamic> json) {
    return SendVoteMayors(
      ballotBoxId: json['ballot_box_id'],
      type: json['type'],
      emptyVotes: json['empty_votes'],
      invalidVotes: json['invalid_votes'],
      candidatesWithVotes: json['candidates_with_votes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ballot_box_id': ballotBoxId,
        'type': type,
        'empty_votes': emptyVotes,
        'invalid_votes': invalidVotes,
        'candidates_with_votes': candidatesWithVotes,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "id: $ballotBoxId, invalid: $invalidVotes, Empty: $emptyVotes, candidate:$candidatesWithVotes";
  }
}
