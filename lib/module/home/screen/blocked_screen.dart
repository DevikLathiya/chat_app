import 'package:chat_app/core/constant/app_string_constant.dart';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/constant/image_constants.dart';
import 'package:chat_app/core/utils/common/common_textfield.dart';
import 'package:chat_app/module/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors_constants.dart';

class BlockedScreen extends StatelessWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardScreenController>(
        init: DashboardScreenController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: ColorConstant.homeScreenColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: ColorConstant.homeScreenColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top + 15.h),
              Text(
                AppString.blockedUser,
                textAlign: TextAlign.center,
                style: Theme.of(context).lato600.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor),
              ).paddingSymmetric(horizontal: 20.w),
                        16.h.verticalSpace,
                        Divider(thickness: 1.2.h),
                        16.h.verticalSpace,
                        // CommonSearchTextField(
                        //   controller: controller.searchController,
                        //   hintText: "Search here...",
                        //   fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                        //   prefixIcon: Image.asset(ImageConstants.search, scale: 3.5, color: ColorConstant.grey),
                        // ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                            title: Text(
                              "Theresa Webb",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.blackColor),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 20.w),
                              decoration: BoxDecoration(
                                color: index  ==0 ? ColorConstant.primary : controller.themeController.isDarkTheme.value ? ColorConstant.f3f4f6Color.withOpacity(0.08) : ColorConstant.f3f4f6Color,
                                borderRadius: BorderRadius.circular(58.r)
                              ),
                              child: Text(AppString.unblock,
                                  style: index  ==0
                                      ? Theme.of(context).lato700.copyWith(fontSize: 12.sp, color:  ColorConstant.white)
                                      : Theme.of(context).lato400.copyWith(fontSize: 12.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor :  ColorConstant.grey)
                              ),
                            ),
                            leading: ClipOval(child: Container(color: ColorConstant.greyLite, child: Image.asset(ImageConstants.getStarted, height: 40.w, width: 40.w))),
                          );
                        },
                        separatorBuilder: (context, index) => 16.h.verticalSpace,
                        itemCount: 7,
                      ).paddingSymmetric(horizontal: 20.w),
                    ),
                  ),
                ],
              ));
        });
  }
}