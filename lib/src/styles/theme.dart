import 'package:earnwise/src/styles/palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    primaryColor: Palette.primary,
    primarySwatch: Palette.primarySwatch,
    brightness: Brightness.dark,
    // fontFamily: GoogleFonts.inter().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Palette.appBarColor,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.primary),
        textStyle: MaterialStateProperty.all(
          TextStyle(color: Palette.white)
        )
      )
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 10,
      color: Color(0xff481F9F),
      shape: CircularNotchedRectangle()
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xff481F9F),
      elevation: 1.0,
      selectedItemColor: Palette.white,
      unselectedItemColor: const Color(0xffD9C6FF),
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        color: Palette.white
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xffD9C6FF)
      )
    ),
    scaffoldBackgroundColor: Palette.darkColor
  );

  static ThemeData get lightTheme => ThemeData(
    primaryColor: Palette.primary,
    primarySwatch: Palette.primarySwatch,
    brightness: Brightness.light,
    // fontFamily: GoogleFonts.inter().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Palette.primary
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.primary),
        textStyle: MaterialStateProperty.all(
          TextStyle(color: Palette.white)
        )
      )
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 10,
      color: Colors.white,
      shape: CircularNotchedRectangle()
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1.0,
      selectedItemColor: Palette.primary,
      showUnselectedLabels: true,
      unselectedItemColor: const Color(0xffB7D4C9),
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xff6B7280)
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xff6B7280)
      )
    ),
    scaffoldBackgroundColor: Palette.white,
  );
}