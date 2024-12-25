import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../constant/colors_constants.dart';

class CommonWidgets {
  CommonWidgets._();

  static String convertDate(String date) {
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
    String outputDate = DateFormat("d MMM yyyy").format(parsedDate);
    return outputDate;
  }
}

class CommonToast {
  CommonToast._();

  static toast({required String msg, ToastGravity? gravity}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.primary,
        textColor: Colors.white,
        fontSize: 16.sp);
  }
}
