import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  focusColor: Colors.black,
  cardColor: const Color(0xFFF5F6F9),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.white54,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Monsterrat",
  inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(secondary: Colors.black)
      .copyWith(background: const Color(0xFFE5E5E5)),
);

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide.none,
    gapPadding: 10,
  );
  return InputDecorationTheme(
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    labelStyle: const TextStyle(color: Colors.white),
    hintStyle: const TextStyle(color: Colors.white),
    border: outlineInputBorder,
  );
}
