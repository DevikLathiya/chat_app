import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/constant/image_constants.dart';
import 'package:chat_app/core/utils/common/common_textfield.dart';
import 'package:chat_app/module/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:chat_app/module/home/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top + 15.h),
                        Row(
                          children: [
                            Text(
                              'Logo',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).lato600.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor),
                            ),
                            const Spacer(),
                            Container(
                              height: 42.w,
                              width: 42.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: controller.themeController.isDarkTheme.value ? ColorConstant.white.withOpacity(0.08) : ColorConstant.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(ImageConstants.search,
                                  height: 16.h, width: 16.w, color: controller.themeController.isDarkTheme.value ? null : ColorConstant.blackOnly),
                            ),
                            12.w.horizontalSpace,
                            Container(
                              height: 42.w,
                              width: 42.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorConstant.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(ImageConstants.favoriteFill, height: 16.h, width: 16.w),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.w),
                        16.h.verticalSpace,
                        Divider(thickness: 1.2.h),
                        CommonSearchTextField(
                          controller: controller.searchController,
                          hintText: "Search here...",
                          fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                          prefixIcon: Image.asset(ImageConstants.search, scale: 3.5, color: ColorConstant.grey),
                        ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
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
                          return GestureDetector(
                            onTap: () {
                              Get.to(ChatScreen());
                            },
                            child: ListTile(
                              tileColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                              title: Text(
                                "Theresa Webb",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.blackColor),
                              ).paddingOnly(bottom: 7.h),
                              subtitle: Text(
                                "Hey !!! Theresa Webb",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .lato400
                                    .copyWith(fontSize: 14.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor : ColorConstant.grey),
                              ),
                              trailing: Column(children: [
                                Text(
                                  "10:35 PM",
                                  style: Theme.of(context)
                                      .lato400
                                      .copyWith(fontSize: 12.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor : ColorConstant.grey),
                                )
                              ]),
                              leading: ClipOval(child: Container(color: ColorConstant.greyLite, child: Image.asset(ImageConstants.getStarted, height: 50.w, width: 50.w))),
                            ),
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
