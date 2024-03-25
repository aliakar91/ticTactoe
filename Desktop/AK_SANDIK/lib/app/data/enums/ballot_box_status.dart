enum Status {
  one,
  two,
  three,
}

extension StatusExtension on Status {
  String get value => (index + 1).toString();
}
