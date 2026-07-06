import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/widgets/book_widget.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.emptyText,
    required this.onEdited,
  });

  final List<BookObject> books;
  final String emptyText;
  final void Function() onEdited;

  @override
  Widget build(BuildContext context) {
    if (books.isNotEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            spacing: 8,
            children: List.generate(
              books.length,
              (index) => BookWidget(
                bookObject: books[index],
                onEdited: () {
                  onEdited();
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(child: Text(emptyText, style: TextStyle(fontSize: 16)));
    }
  }
}
