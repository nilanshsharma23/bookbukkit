import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/classes/status_enum.dart';
import 'package:bookbukkit/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          onPressed: () {
            context.push('/add-book');
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                spacing: 8,
                children: [
                  BookWidget(
                    bookObject: BookObject(
                      title: "The Name of the Wind",
                      author: "Patrick Rothfuss",
                      pagesDone: 20,
                      totalPages: 300,
                      status: Status.reading,
                      notes:
                          "HELLLLLLLLLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO",
                    ),
                  ),
                ],
              ),
            ),
            Center(child: Text("Finished")),
            Center(child: Text("Want to read")),
          ],
        ),
      ),
    );
  }
}
