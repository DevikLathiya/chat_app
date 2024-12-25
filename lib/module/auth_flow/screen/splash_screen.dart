import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import '../../../core/constant/image_constants.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        controller.splash.value;
        return Scaffold(
          body: Center(child: Image.asset(ImageConstants.appLogo, width: 280.sp)),
        );
      },
    );
  }
}
