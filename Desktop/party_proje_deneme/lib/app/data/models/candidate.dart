class Candidate {
  String id;
  String name;
  String image;
  String type;
  int? vote;
  int? invalidVote;
  int? emptyVote;

  Candidate({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    this.vote = 0,
    this.invalidVote = 0,
    this.emptyVote=0,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        //vote: json["vote"],
        //invalidVote: json["invalidVote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "type": type,
        //"vote":vote,
        //"invalidVote":invalidVote,
      };

  @override
  String toString() {
    // TODO: implement toString
    return id + name + image + type;
  }
}
