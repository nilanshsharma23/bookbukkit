import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/classes/status_enum.dart';
import 'package:bookbukkit/functions/get_specific_books.dart';
import 'package:bookbukkit/widgets/book_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookObject> currentlyReadingBooks = [];
  List<BookObject> finishedBooks = [];
  List<BookObject> wantToReadBooks = [];

  @override
  void initState() {
    super.initState();
    currentlyReadingBooks = getSpecificBooks(status: Status.reading);
    finishedBooks = getSpecificBooks(status: Status.finished);
    wantToReadBooks = getSpecificBooks(status: Status.wantToRead);
  }

  void onEdited() {
    setState(() {
      currentlyReadingBooks = getSpecificBooks(status: Status.reading);
      finishedBooks = getSpecificBooks(status: Status.finished);
      wantToReadBooks = getSpecificBooks(status: Status.wantToRead);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("bookbukkit", style: GoogleFonts.uncialAntiqua()),
          bottom: TabBar(
            tabs: [
              Tab(text: "Currently Reading"),
              Tab(text: "Finished"),
              Tab(text: "Want to read"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.push('/add-book');
            onEdited();
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            BookList(
              books: currentlyReadingBooks,
              onEdited: onEdited,
              emptyText: "Currently reading no books.",
            ),
            BookList(
              books: finishedBooks,
              onEdited: onEdited,
              emptyText: "Haven't finished any books.",
            ),
            BookList(
              books: wantToReadBooks,
              onEdited: onEdited,
              emptyText: "Don't want to read any books?",
            ),
          ],
        ),
      ),
    );
  }
}
