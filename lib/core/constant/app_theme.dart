import 'package:flutter/material.dart';
import 'colors_constants.dart';
import 'font_size_constant.dart';

class AppTheme {
  AppTheme._();

  // static ThemeData lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   useMaterial3: false,
  //   scaffoldBackgroundColor: ColorConstant.scaffoldBackground,
  //   textSelectionTheme: TextSelectionThemeData(
  //     cursorColor: ColorConstant.primary,
  //     selectionHandleColor: ColorConstant.primary,
  //     selectionColor: ColorConstant.primaryOpacated,
  //   ),
  // );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstant.scaffoldBackground,
    useMaterial3: false,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorConstant.scaffoldBackground,
    useMaterial3: false,
  );
}


extension CustomThemeExtension on ThemeData {

  // TextStyle get lato700 => TextStyle(fontFamily: Fonts.latoBold, color: ColorConstant.appTxtColor);

  TextStyle get lato700 => TextStyle(fontFamily: Fonts.latoSemiBold, color: ColorConstant.appTxtColor);

  TextStyle get lato600 => TextStyle(fontFamily: Fonts.latoRegular, color: ColorConstant.appTxtColor,fontWeight: FontWeight.w600);

  TextStyle get lato500 => TextStyle(fontFamily: Fonts.latoRegular, color: ColorConstant.appTxtColor,fontWeight: FontWeight.w500);

  TextStyle get lato400 => TextStyle(fontFamily: Fonts.latoRegular, color: ColorConstant.appTxtColor,fontWeight: FontWeight.w400);

  TextStyle get lato300  => TextStyle(fontFamily: Fonts.latoLight, color: ColorConstant.appTxtColor);
}
