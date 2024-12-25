import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/utils/common/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/colors_constants.dart';
import '../../constant/value_constants.dart';

class CommonBottomSheet {
  static getCommonBottomSheet({
    String? title,
    required String buttonText,
    required Widget body,
    isPaddingNecessary = true,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    bool wantDraggableContainer = true,
     required void Function() onTap,
  }) {
    return showModalBottomSheet(
      context: navigatorKey.currentState!.context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(30.r),topLeft: Radius.circular(30.r))),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height , maxWidth: Get.width),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(color: ColorConstant.bottomSheetBackground, borderRadius: BorderRadius.only(topRight:Radius.circular(30.r),topLeft: Radius.circular(30.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) 24.verticalSpace,
                if (title != null) Text(title, style: Theme.of(context).lato700.copyWith(fontSize: 20.sp)),
                Flexible(
                  child: Padding(
                    padding: isPaddingNecessary ? padding ?? EdgeInsets.fromLTRB(24.r, 24.r, 24.r, 14.r) : EdgeInsets.all(0.w),
                    child: SingleChildScrollView(child: body),
                  ),
                ),
                Padding(
                  padding: isPaddingNecessary ? padding ?? EdgeInsets.fromLTRB(24.r, 0.r, 24.r, 14.r) : EdgeInsets.all(0.w),
                  child: CommonButton(onTap: onTap, buttonText: buttonText),
                ),
                10.h.verticalSpace
              ],
            ),
          ),
        );
      },
    );
  }
}