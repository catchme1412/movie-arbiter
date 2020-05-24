import 'package:flutter/material.dart';

final ThemeData DARK_THEME = ThemeData(
  backgroundColor: Colors.blueGrey[900],
  primarySwatch: Colors.orange,
  accentColor: Colors.white,
  primaryColor: Colors.blueGrey[900],
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.white),
  ),
  pageTransitionsTheme: PageTransitionsTheme(),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    color: Colors.black87,
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.white),
    ),
  ),
);
