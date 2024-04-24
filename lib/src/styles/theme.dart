import 'package:earnwise/src/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    primaryColor: Palette.primary,
    primarySwatch: Palette.primarySwatch,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.raleway().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Palette.darkColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: Palette.white, 
            fontFamily: GoogleFonts.raleway().fontFamily
          )
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
      elevation: 2.0,
      selectedItemColor: Palette.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white30,
      selectedLabelStyle: TextStyle(
        fontSize: 14,
        color: Palette.white
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xffD9C6FF)
      )
    ),
    scaffoldBackgroundColor: Palette.darkColor
  );

  static ThemeData get lightTheme => ThemeData(
    primaryColor: Palette.primary,
    primarySwatch: Palette.primarySwatch,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.raleway().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: Palette.white, 
            fontFamily: GoogleFonts.raleway().fontFamily
          )
        )
      )
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 10,
      color: Colors.white,
      shape: CircularNotchedRectangle()
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xff481F9F),
      elevation: 2.0,
      selectedItemColor: Palette.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white30,
      selectedLabelStyle: TextStyle(
        fontSize: 14,
        color: Palette.white
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xffD9C6FF)
      )
    ),
    scaffoldBackgroundColor: Palette.white,
  );
}