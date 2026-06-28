import 'dart:convert';

import 'package:bookbukkit/classes/book_object.dart';
import 'package:bookbukkit/classes/globals.dart';
import 'package:bookbukkit/classes/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController pagesDoneController = TextEditingController();
  TextEditingController totalPagesController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  Status status = Status.reading;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Book", style: GoogleFonts.uncialAntiqua()),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BOOK DETAILS",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withAlpha(178),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: "The Hitchhiker's Guide to the Galaxy",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer,
                        filled: true,
                      ),
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter something.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Author",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: "Douglas Adams",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer,
                        filled: true,
                      ),
                      controller: authorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter something.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 16,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pages Done",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "30",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                    ),
                                  ),
                                  fillColor: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                  filled: true,
                                ),
                                controller: pagesDoneController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter something.';
                                  }

                                  if (int.tryParse(value) == null) {
                                    return 'Enter a valid number.';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pages",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "300",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                    ),
                                  ),
                                  fillColor: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                  filled: true,
                                ),
                                keyboardType: TextInputType.number,
                                controller: totalPagesController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter something.';
                                  }

                                  if (int.tryParse(value) == null) {
                                    return 'Enter a valid number.';
                                  }

                                  if (int.parse(value) <
                                      int.parse(pagesDoneController.text)) {
                                    return 'Total pages must be bigger than or equal to pages done.';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      "SHELF",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withAlpha(178),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    ChoiceChip(
                      label: Row(
                        spacing: 4,
                        children: [Icon(Icons.book), Text("Reading")],
                      ),
                      selected: status == Status.reading,
                      onSelected: (value) => setState(() {
                        status = Status.reading;
                      }),
                    ),
                    SizedBox(height: 4),
                    ChoiceChip(
                      label: Row(
                        spacing: 4,
                        children: [Icon(Icons.bookmark), Text("Want To Read")],
                      ),
                      selected: status == Status.wantToRead,
                      onSelected: (value) => setState(() {
                        status = Status.wantToRead;
                      }),
                    ),
                    SizedBox(height: 4),
                    ChoiceChip(
                      label: Row(
                        spacing: 4,
                        children: [Icon(Icons.check), Text("Finished")],
                      ),
                      selected: status == Status.finished,
                      onSelected: (value) => setState(() {
                        status = Status.finished;
                      }),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      "NOTES",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withAlpha(178),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: "Thoughts, quotes...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer,
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: notesController,
                      maxLines: null,
                      minLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter something.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          setState(() {
                            loading = true;
                          });

                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          BookObject bookObject = BookObject(
                            title: titleController.text,
                            author: authorController.text,
                            pagesDone: int.parse(pagesDoneController.text),
                            totalPages: int.parse(totalPagesController.text),
                            status: status,
                            notes: notesController.text,
                          );

                          Globals.currentBooks.add(bookObject);

                          sharedPreferences.setStringList(
                            'books',
                            List.generate(
                              Globals.currentBooks.length,
                              (index) => json.encode(
                                Globals.currentBooks[index].toJson(),
                              ),
                            ),
                          );

                          setState(() {
                            loading = false;
                          });

                          if (context.mounted) {
                            context.pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                        child: Text(
                          "Save Book",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (loading)
            SpinKitRotatingPlain(
              color: Theme.of(context).colorScheme.onSurface,
              size: 32,
            ),
        ],
      ),
    );
  }
}
