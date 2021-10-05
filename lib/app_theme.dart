import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

class AppTheme{

  static final TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff212121)
    )
  );

  static ThemeData build() => ThemeData(
    // appBarTheme: , agregar color
    // primarySwatch: Colors.yellow,
    backgroundColor: LdColors.white,
    brightness: Brightness.light,
  );
}

extension GFilesAttributes on TextTheme{

  TextStyle get titleWhite => bodyText1!.copyWith(
      color: LdColors.white,
      fontSize: 24,
      fontWeight: FontWeight.w700
  );
}