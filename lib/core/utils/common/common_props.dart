import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/colors_constants.dart';

class CommonProps {
  CommonProps._();

  static InputBorder textFieldWhiteBorder([double? radius,Color? borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 4.sp),
        borderSide: BorderSide(color: borderColor ?? ColorConstant.fillColor),
      );

}
