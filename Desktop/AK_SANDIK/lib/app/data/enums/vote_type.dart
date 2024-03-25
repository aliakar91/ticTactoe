enum VoteType {
  city,
  district,
  council,
}

extension VoteTypeExtension on VoteType {
  String get value => (index + 1).toString();
}
