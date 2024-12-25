import 'package:flutter/material.dart';

import '../../../../core/constant/colors_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.homeScreenColor,
      body: Center(child: Text("0000"),),
    );
  }
}
class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.homeScreenColor,
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.homeScreenColor,
      body: Center(child: Text("22222"),),
    );
  }
}
