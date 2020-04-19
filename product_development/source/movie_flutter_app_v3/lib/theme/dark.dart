import 'package:flutter/material.dart';

final ThemeData DARK_THEME = ThemeData(
    backgroundColor: Colors.blueGrey[900],
    primarySwatch: Colors.orange,
    accentColor: Colors.grey,
    primaryColor: Colors.blueGrey[900],
    textTheme: TextTheme(
      title: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
    ),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.black87,
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.white),
      ),
    ));
