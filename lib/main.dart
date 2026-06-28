import 'package:bookbukkit/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          surface: Color(0xFFFBF7F0),
          surfaceContainerLow: Color(0xFFFAF5EE),
          surfaceContainer: Color(0xFFF2EAE0),
          outline: Color(0xFFE0D4C4),
          outlineVariant: Color(0xFFC8B89A),
          onSurface: Color(0xFF3D2B1F),
          onSurfaceVariant: Color(0xFF7A5C44),
          primary: Color(0xFFC4794A),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFF2D9C8),
          onPrimaryContainer: Color(0xFF8C4A26),
          secondary: Color(0xFF2E6B28),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFD9EDD6),
          onSecondaryContainer: Color(0xFF2E6B28),
          tertiary: Color(0xFF7A4E10),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFF5E6C8),
          onTertiaryContainer: Color(0xFF7A4E10),
          error: Color(0xFFBA1A1A),
          onError: Color(0xFFFFFFFF),
          errorContainer: Color(0xFFFFDAD6),
          onErrorContainer: Color(0xFF410002),
        ),
      ),
    );
  }
}
