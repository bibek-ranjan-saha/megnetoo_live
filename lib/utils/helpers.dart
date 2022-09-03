import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: const AppBarTheme(
    color: Colors.black54,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
  ),
);

var lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.grey.shade200,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 26, fontWeight: FontWeight.w900),
    centerTitle: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.white54,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
