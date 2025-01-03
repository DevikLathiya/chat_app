import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'app_theme_controller.dart';

class ColorConstant {

  static var themeController = Get.find<ThemeController>();
  ColorConstant._();


  static Color transparent = Colors.transparent;
  static Color primary = const Color(0xFF3B8AFF);
  static Color grey = const Color(0xFF667085);
  static Color greyLite = const Color(0xFFF0F1F3);
  static Color white =  Colors.white ;
  static Color blackOnly = Colors.black ;
  static Color get black => (themeController.isDarkTheme.value) ? Colors.black : Colors.white ;
  static Color get blackColor => (themeController.isDarkTheme.value) ? Colors.white : Colors.black ;
  static Color get whiteMode => (themeController.isDarkTheme.value) ? Colors.white : Colors.black;
  static Color get appTxtColor => (themeController.isDarkTheme.value) ? Colors.white :  Color(0xFF22172A);
  static Color get scaffoldBackground => (themeController.isDarkTheme.value) ? const Color(0xFF1C1C26) : const Color(0xFFFFFFFF);
  static Color get bottomSheetBackground => (themeController.isDarkTheme.value) ? const Color(0xFF323240) : const Color(0xFFFFFFFF);


  static Color hintColor =  Color(0xFF959595);
  static Color fillColor =  Color(0xFFF0F1F3B2);
  static Color f3f4f6Color =  Color(0xFFF3F4F6);
  static Color e3E4BColor =  Color(0xFF3E3E4B);
  static Color lightBlue =  Color(0xFFE0ECFF);
  static Color chatTileColor =  Color(0xFF22304D);
  static Color get homeScreenColor => (themeController.isDarkTheme.value) ?  Color(0xFF1C1C26) : Color(0xFFF4F4F4);

  static Color chatTextFiled =  Color(0xFF323240);


}
