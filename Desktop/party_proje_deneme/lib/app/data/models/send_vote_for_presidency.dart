class SendVoteForPresidency {
  int ballotBoxId;
  int emptyVotes;
  int invalidVotes;
  List<Map<String, dynamic>> candidatesWithVotes;

  SendVoteForPresidency({
    required this.ballotBoxId,
    required this.emptyVotes,
    required this.invalidVotes,
    required this.candidatesWithVotes,
  });

  factory SendVoteForPresidency.fromJson(Map<String, dynamic> json) {
    return SendVoteForPresidency(
      ballotBoxId: json['ballot_box_id'],
      emptyVotes: json['empty_votes'],
      invalidVotes: json['invalid_votes'],
      candidatesWithVotes: json['candidates_with_votes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ballot_box_id': ballotBoxId,
        'empty_votes': emptyVotes,
        'invalid_votes': invalidVotes,
        'candidates_with_votes': candidatesWithVotes,
      };

}
