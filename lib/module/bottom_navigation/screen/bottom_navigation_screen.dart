import 'package:chat_app/core/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_theme_controller.dart';
import '../../../core/constant/colors_constants.dart';
import '../../../core/constant/image_constants.dart';
import '../controller/bottom_navigation_controller.dart';


class BottomNavigationBarUI extends StatelessWidget {

  const BottomNavigationBarUI({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardScreenController>(
      init: DashboardScreenController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          backgroundColor: ColorConstant.homeScreenColor,
          body: controller.tabWidgets[controller.currentIndex.value],

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.currentIndex.value = 1;
            },
            shape: const CircleBorder(),
            backgroundColor: ColorConstant.primary,
            child: Image.asset(ImageConstants.home,height: 28.h,),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,height: 76.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.currentIndex.value = 0;
                      // var cnt = Get.find<ThemeController>();
                      // cnt.changeTheme();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 26.h,
                          fit: BoxFit.cover,
                          controller.currentIndex.value == 0 ? ImageConstants.fillProfile : ImageConstants.profileIcon,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Profile',
                          style: Theme.of(context).lato500.copyWith(
                                fontSize: 12.sp,
                                color: controller.currentIndex.value == 0 ? ColorConstant.blackColor : ColorConstant.blackColor.withOpacity(0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
                      controller.currentIndex.value = 2;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 26.h,
                          fit: BoxFit.cover,
                          controller.currentIndex.value == 2 ? ImageConstants.fillBlock : ImageConstants.blockIcon,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Blocked',
                          style: Theme.of(context).lato500.copyWith(
                            fontSize: 12.sp,
                            color: controller.currentIndex.value == 2 ? ColorConstant.blackColor : ColorConstant.blackColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}