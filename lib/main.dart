import 'package:chat_app/core/utils/common/common_button.dart';
import 'package:chat_app/module/auth_flow/screen/onboarding.dart';
import 'package:chat_app/module/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'core/constant/app_theme_controller.dart';
import 'core/utils/common/common_bottomsheet.dart';
import 'dart:io';
import 'package:chat_app/core/utils/extension/ext_on_wid.dart';
import 'package:chat_app/module/auth_flow/screen/splash_screen.dart';
import 'package:chat_app/services/root_bindings/binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/constant/app_theme.dart';
import 'core/constant/enums.dart';
import 'core/constant/value_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      AppInitialize.initApp().then((init) {
        runApp(const MyApp().dismissKeyboard());
      });
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    print("Get.isDarkMode ::: $isDarkMode  ");
    print("Get.isDarkMode ::: ${Get.isDarkMode}  ");

    final ThemeController themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(figmaWidth, figmaHeight),
      child: GetMaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        home: BottomNavigationBarUI(),
        scrollBehavior: AppScrollBehavior(),
        initialBinding: RootBinding(),
      ),
    );
  }
}

class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
