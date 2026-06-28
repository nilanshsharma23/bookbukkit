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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pages_done': pagesDone,
      'total_pages': pagesDone,
      'status': status.value,
      'notes': notes,
    };
  }

  factory BookObject.fromJson(Map<String, dynamic> data) {
    return BookObject(
      title: data['title'],
      author: data['author'],
      pagesDone: data['pages_done'],
      totalPages: data['total_pages'],
      status: Status.fromString(data['status']),
      notes: data['notes'],
    );
  }
}
