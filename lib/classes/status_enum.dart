enum Status {
  wantToRead(label: "Want To Read", value: "want_to_read"),
  reading(label: "Reading", value: "reading"),
  finished(label: "Finished", value: "finished");

  final String label;
  final String value;

  const Status({required this.label, required this.value});

  static Status fromString(String value) {
    return Status.values.firstWhere((element) => element.value == value);
  }
}
