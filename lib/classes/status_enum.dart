enum Status {
  wantToRead(data: "Want To Read"),
  reading(data: "Reading"),
  finished(data: "Finished");

  final String data;

  const Status({required this.data});
}
