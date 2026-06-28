import 'package:bookbukkit/pages/add_book_page.dart';
import 'package:bookbukkit/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/add-book', builder: (context, state) => AddBookPage()),
  ],
);
