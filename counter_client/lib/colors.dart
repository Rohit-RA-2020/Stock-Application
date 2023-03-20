import 'package:flutter/material.dart';

List<Color> stockColors = const [
  Color.fromARGB(255, 208, 237, 129),
  Color.fromARGB(255, 84, 217, 201),
  Color.fromARGB(255, 242, 139, 128),
  Color(0xFFD0FFFE),
];

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF16151A),
  canvasColor: Colors.transparent,
  brightness: Brightness.dark,
);

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFE5E5E5),
  canvasColor: Colors.transparent,
  brightness: Brightness.light,
);
