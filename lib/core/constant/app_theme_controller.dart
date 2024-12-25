import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../utils/storage/storage_constants.dart';
import '../utils/storage/storage_service.dart';

class ThemeController extends GetxController {
  ThemeController() {
    StorageService.getKey(key: StorageConstants.theme).then(
      (value) {
        setTheme(value);
      },
    );
  }

  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    toggleTheme();
  }

  ThemeMode get theme => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    isDarkTheme.value = brightness == Brightness.dark;
    isDarkTheme.refresh();
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
    StorageService.setKey(key: StorageConstants.theme, value: isDarkTheme.value ? ThemeMode.dark.name : ThemeMode.light.name);
  }

  void changeTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
    StorageService.setKey(key: StorageConstants.theme, value: isDarkTheme.value ? ThemeMode.dark.name : ThemeMode.light.name);
  }

  setTheme(String? themeValue) {
    Get.changeThemeMode(themeValue == "dark" ? ThemeMode.dark : ThemeMode.light);
  }
}
