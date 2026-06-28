import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/classes/globals.dart';
import 'package:bookbukkit/classes/status_enum.dart';

List<BookObject> getSpecificBooks({required Status status}) {
  List<BookObject> output = [];

  output.addAll(
    Globals.currentBooks.where((element) => element.status == status),
  );

  return output;
}
