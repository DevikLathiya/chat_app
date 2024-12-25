import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/utils/extension/ext_on_wid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app_controller/app_controller.dart';
import '../../core/constant/colors_constants.dart';
import '../../core/constant/value_constants.dart';
import '../../core/utils/common/app_loader.dart';
import '../../core/utils/common/common_widgets.dart';
import 'model/api_response_model.dart';

class ApiValidation {
  static AppController appController = Get.find<AppController>();

  ApiValidation._();

  static validateResponse(ApiResponseModel? apiResponseModel, {bool showLoader = true}) async {
    if (apiResponseModel?.statusCode == 200 || apiResponseModel?.statusCode == 201) return true;
    if (showLoader) AppLoader.removeLoader();
    await caseByStatusCode(apiResponseModel);
  }

  static caseByStatusCode(ApiResponseModel? apiResponseModel) async {
    if (apiResponseModel?.statusCode == 499 || apiResponseModel?.statusCode == 498) {
      await appController.removeAllKeysAndLogout();
      return;
    }
    if (apiResponseModel?.statusCode == 406) {
      // showDialogueAccordingResponse(apiResponseModel?.responseData['errors'].first);
      CommonToast.toast(msg: apiResponseModel?.responseData['errors'].first);
    } else if (apiResponseModel?.statusCode == 998 || apiResponseModel?.statusCode == 401 || apiResponseModel?.statusCode == 422) {
      // showDialogueAccordingResponse(apiResponseModel?.messageText ?? "");
      CommonToast.toast(msg: apiResponseModel?.messageText ?? "");
    }
  }

  static showDialogueAccordingResponse(String message) async {
    BuildContext context = navigatorKey.currentState!.context;
    return showDialog(
      context: navigatorKey.currentState!.context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          insetAnimationCurve: Curves.slowMiddle,
          insetPadding: EdgeInsets.all(20.sp),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Pocket Trainer", style: Theme.of(context).lato600.copyWith(fontSize: 20.sp)),
                14.sp.verticalSpace,
                Text(message, style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.hintColor)),
                20.sp.verticalSpace,
                Text("Ok", style: Theme.of(context).lato500.copyWith(fontSize: 20.sp, color: ColorConstant.hintColor)).addGesture(() => Get.back()),
              ],
            ),
          ).paddingAll(16.sp),
        );
      },
    );
  }
}
