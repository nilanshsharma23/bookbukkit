import 'dart:convert';

import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/classes/globals.dart';
import 'package:bookbukkit/pages/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({
    super.key,
    required this.bookObject,
    required this.onEdited,
  });

  final BookObject bookObject;
  final void Function() onEdited;

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  final FocusNode buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookObject.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.bookObject.author,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.bookObject.status.label,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),
                          ),
                          LinearPercentIndicator(
                            percent:
                                widget.bookObject.pagesDone /
                                widget.bookObject.totalPages,
                            progressColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            width: 100,
                            barRadius: Radius.circular(8),
                          ),
                          Text(
                            "${((widget.bookObject.pagesDone / widget.bookObject.totalPages) * 100).floor()}%",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AddBookPage(initialBookData: widget.bookObject),
                        ),
                      );
                      setState(() {});
                      widget.onEdited();
                    },
                    child: Text("Edit"),
                  ),
                  MenuItemButton(
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      setState(() {
                        Globals.currentBooks.removeWhere(
                          (element) => element.uid == widget.bookObject.uid,
                        );
                      });

                      await sharedPreferences.setStringList(
                        'books',
                        List.generate(
                          Globals.currentBooks.length,
                          (index) =>
                              json.encode(Globals.currentBooks[index].toJson()),
                        ),
                      );

                      widget.onEdited();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
                builder: (context, controller, child) {
                  return IconButton(
                    onPressed: () {
                      controller.isOpen
                          ? controller.close()
                          : controller.open();
                    },
                    icon: Icon(Icons.more_vert),
                  );
                },
              ),
            ],
          ),
          if (widget.bookObject.notes.isNotEmpty)
            Text(
              "\"${widget.bookObject.notes}\"",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
