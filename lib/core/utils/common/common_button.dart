import 'package:chat_app/core/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../constant/colors_constants.dart';

class CommonButton extends StatelessWidget {
  final Callback onTap;
  final double? width;
  final String buttonText;
  final Color? borderColor;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CommonButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.borderColor,
    this.fontWeight,
    this.color,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? ColorConstant.primary,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor ?? ColorConstant.transparent),
        ),
        height: 52.h,
        width: width ?? double.infinity,
        child: Text(
          buttonText,
          style: Theme.of(context).lato600.copyWith(fontSize: 18.sp,  color: textColor ?? ColorConstant.white, fontWeight: fontWeight ?? fontWeight)
        ),
      ),
    );
  }
}

class CommonWidgetButton extends StatelessWidget {
  final Callback onTap;
  final double? width;
  final Widget child;
  final Color? borderColor;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CommonWidgetButton({
    super.key,
    required this.onTap,
    required this.child,
    this.borderColor,
    this.fontWeight,
    this.color,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Container(
        height: 54.sp,
        alignment: Alignment.center,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? ColorConstant.primary,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor ?? ColorConstant.transparent),
        ),
        child: child,
      ),
    );
  }
}
