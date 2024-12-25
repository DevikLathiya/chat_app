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


  static Color hintColor = const Color(0xFF959595);
  static Color fillColor = const Color(0xFFF0F1F3B2);
  static Color get homeScreenColor => (themeController.isDarkTheme.value) ? const Color(0xFF1C1C26) : Color(0xFFF4F4F4);
}
