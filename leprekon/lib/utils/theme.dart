import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffF4F4F4),
    colorScheme: const ColorScheme.light(
      surface: Color(0xffF4F4F4),
      primary: Color(0xff4BB955),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff20265F),
    bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Color(0xff1B2051)),
      colorScheme: const ColorScheme.dark(
        surface: Color(0xff20265F),
        primary: Color(0xff4BB955),
        secondary: Color(0xff1B2051),
        tertiary: Color(0xff776BFE),
    ));
