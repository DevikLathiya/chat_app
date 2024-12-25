import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_theme_controller.dart';
import '../../../core/constant/colors_constants.dart';
import '../../../core/constant/image_constants.dart';
import '../../home/controller/screen/home_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../model/bottom_navigation_bar_item_model.dart';
import '../screen/bottom_navigation_screen.dart';

class DashboardScreenController extends GetxController {

  var themeController = Get.find<ThemeController>();

  RxInt currentIndex = RxInt(1);

  TextEditingController searchController = TextEditingController();

  List<Widget> tabWidgets = [const ProfileScreen(), const HomeScreen(),const HomeScreen2()];

  Widget get selectedTabWidgets {
    return tabWidgets[currentIndex.value];
  }

  List<BottomNavigationItemModel> tabBarItems = [
    BottomNavigationItemModel(
      icon: ImageConstants.profileIcon,
      activeIcon: ImageConstants.fillProfile,
      title: "Profile",
    ),

    BottomNavigationItemModel(
      icon: ImageConstants.blockIcon,
      activeIcon: ImageConstants.fillBlock,
      title: 'Blocked',
    ),
  ];

  void changeNavigationTab({required int newIndex}) {
    currentIndex.value = newIndex;
    print(currentIndex.value);
  }
}
