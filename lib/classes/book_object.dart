import 'package:bookbukkit/classes/status_enum.dart';

class BookObject {
  final String title;
  final String author;
  final int pagesDone;
  final int totalPages;
  final Status status;
  final String notes;

  BookObject({
    required this.title,
    required this.author,
    required this.pagesDone,
    required this.totalPages,
    required this.status,
    this.notes = "",
  });
}
