import 'package:flutter/material.dart';

import 'screens/app_shell.dart';

void main() {
  runApp(const AccordMasterApp());
}

class AccordMasterApp extends StatelessWidget {
  const AccordMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AccordMaster',
      theme: ThemeData(
        fontFamily: 'AppRoboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEF476F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F1EA),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF3F1EA),
          foregroundColor: Color(0xFF172124),
          elevation: 0,
          centerTitle: false,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}
