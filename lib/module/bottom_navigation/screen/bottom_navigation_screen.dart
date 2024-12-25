import 'dart:io';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/colors_constants.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigationBarUI extends StatelessWidget {
  final int? currentIndex;

  const BottomNavigationBarUI({super.key, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardScreenController>(
      init: DashboardScreenController(),
      initState: (state) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   state.controller!.currentIndex.value = currentIndex ?? 1;
        // });
      },
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          backgroundColor: ColorConstant.homeScreenColor,
          body: controller.tabWidgets[controller.currentIndex.value],

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.changeNavigationTab(newIndex: 1);
            },
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 12,
            color: Colors.white,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white, primaryColor: Colors.grey),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (i) => controller.changeNavigationTab(newIndex: i),
                selectedItemColor: ColorConstant.blackColor,
                unselectedItemColor: ColorConstant.blackColor.withOpacity(0.6),
                selectedLabelStyle: Theme.of(context).lato500.copyWith(fontSize: 12.sp,color: ColorConstant.blackColor.withOpacity(0.6)),
                unselectedLabelStyle: Theme.of(context).lato500.copyWith(fontSize: 12.sp,color: ColorConstant.blackColor),
                items: controller.tabBarItems
                    .map(
                      (e) => BottomNavigationBarItem(
                        backgroundColor: ColorConstant.black,
                        label: e.title ?? '',
                        icon: Image.asset(
                          controller.tabBarItems.indexOf(e) == controller.currentIndex.value ? e.activeIcon ?? '' : e.icon ?? '',
                          height: 26.sp,
                          width: 26.sp,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          // bottomNavigationBar: BottomAppBar(
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   shape: CircularNotchedRectangle(),
          //   child: Theme(
          //     data: Theme.of(context)
          //         .copyWith(canvasColor: Colors.white, primaryColor: Colors.grey),
          //     child: BottomNavigationBar(
          //       onTap: (index) {
          //
          //       },
          //       type: BottomNavigationBarType.fixed,
          //
          //       items: controller.tabBarItems
          //           .map(
          //             (e) => BottomNavigationBarItem(
          //           backgroundColor: ColorConstant.black,
          //           label: e.title ?? '',
          //           icon: Image.asset(
          //             controller.tabBarItems.indexOf(e) == controller.currentIndex.value ? e.activeIcon ?? '' : e.icon ?? '',
          //             height: 20.sp,
          //             width: 20.sp,
          //           ),
          //         ),
          //       )
          //           .toList(),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
