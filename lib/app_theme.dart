import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

class AppTheme{

  static const TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontFamily: 'GTWalsheimPro',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: Color(0xff212121),
    ),
  );

  static ThemeData build() => ThemeData(
    // appBarTheme: , agregar color
    // primarySwatch: Colors.yellow,
    backgroundColor: LdColors.white,
    brightness: Brightness.light,
  );
}

extension LDailyAttributes on TextTheme{

  TextStyle get titleBigWhite => bodyText1!.copyWith(
    color: LdColors.white,
    fontSize: 55,
    fontWeight: FontWeight.w700,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get titleMediumWhite => bodyText1!.copyWith(
    color: LdColors.white,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get subtitleWhite => bodyText1!.copyWith(
    color: LdColors.white,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textBigWhite => bodyText1!.copyWith(
    color: LdColors.white,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textWhite => bodyText1!.copyWith(
    color: LdColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textSmallWhite => bodyText1!.copyWith(
    color: LdColors.grayText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get titleBigBlack => bodyText1!.copyWith(
    color: LdColors.black,
    fontSize: 55,
    fontWeight: FontWeight.w700,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get subtitleBlack => bodyText1!.copyWith(
    color: LdColors.black,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textBigBlack => bodyText1!.copyWith(
    color: LdColors.black,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textBlack => bodyText1!.copyWith(
    color: LdColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textSmallBlack => bodyText1!.copyWith(
    color: LdColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get titleBigYellow => bodyText1!.copyWith(
    color: LdColors.yellow,
    fontSize: 55,
    fontWeight: FontWeight.w700,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get titleMediumYellow => bodyText1!.copyWith(
    color: LdColors.yellow,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textBigYellow => bodyText1!.copyWith(
    color: LdColors.yellow,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textYellow => bodyText1!.copyWith(
    color: LdColors.yellow,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textGray => bodyText1!.copyWith(
    color: LdColors.gray,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textGreen => bodyText1!.copyWith(
    color: LdColors.green,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );

  TextStyle get textBlue => bodyText1!.copyWith(
    color: LdColors.blue,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'GTWalsheimPro',
  );
}
