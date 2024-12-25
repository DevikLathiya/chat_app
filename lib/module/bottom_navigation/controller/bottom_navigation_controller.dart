import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/colors_constants.dart';
import '../../../core/constant/image_constants.dart';
import '../../home/controller/screen/home_screen.dart';
import '../model/bottom_navigation_bar_item_model.dart';
import '../screen/bottom_navigation_screen.dart';

class DashboardScreenController extends GetxController {
  RxInt currentIndex = RxInt(1);
  List<Widget> tabWidgets = [const HomeScreen(), const HomeScreen1(), const HomeScreen2()];
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
      icon: ImageConstants.home,
      activeIcon: ImageConstants.home,
      title: "",
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
