import 'package:flutter/material.dart';

class MyTheme {
  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(primary: Color(0xff6246EA), secondary: Colors.grey.shade600, outline: Colors.grey.shade800,),
    primaryColor: Colors.white60,
    iconTheme: const IconThemeData(color: Color(0xff6246EA)),
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Color(0xff6246EA), secondary: Colors.grey.shade100, onPrimary: Colors.black),
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(color: Color(0xff6246EA)),
  );
}