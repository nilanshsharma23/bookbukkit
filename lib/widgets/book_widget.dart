import 'dart:math';

import 'package:bookbukkit/classes/book_object.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key, required this.bookObject});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Random().nextBool() ? Icons.book_outlined : Icons.book,
                size: 64,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookObject.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(bookObject.author, style: TextStyle(fontSize: 16)),
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
                          bookObject.status.data,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ),
                      LinearPercentIndicator(
                        percent: bookObject.pagesDone / bookObject.totalPages,
                        progressColor: Theme.of(context).colorScheme.primary,
                        width: 100,
                        barRadius: Radius.circular(8),
                      ),
                      Text(
                        "${((bookObject.pagesDone / bookObject.totalPages) * 100).floor()}%",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
