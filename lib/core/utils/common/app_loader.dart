import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/colors_constants.dart';
import '../../constant/value_constants.dart';

class AppLoader {
  AppLoader._();

  static showLoader() {
    return showDialog(
      context: navigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.sp),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Center(child: CircularProgressIndicator(color: ColorConstant.primary)));
      },
    );
  }

  static removeLoader() {
    Get.back();
  }
}
