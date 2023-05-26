import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static final TextTheme lightTextTheme = TextTheme(
    // quiz question and answer
    headline1: GoogleFonts.nunito(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      height: 1.4,
      color: Color(Palette.mBlack.color),
    ),
    // sidetab text
    headline2: GoogleFonts.nunito(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      height: 1.4,
      color: Color(Palette.mWhite.color),
    ),
  );

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(Palette.mBlack.color),
    scaffoldBackgroundColor: Color(Palette.mWhite.color),
    textTheme: lightTextTheme,
  );
  
  static final TextTheme darkTextTheme = TextTheme(
    // quiz question and answer
    headline1: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.4,
      color: Color(Palette.mWhite.color),
    ),
    // sidetab text
    headline2: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.4,
      color: Color(Palette.mBlack.color),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(Palette.mWhite.color),
    scaffoldBackgroundColor: Color(Palette.mBlack.color),
    textTheme: darkTextTheme,
  );

}