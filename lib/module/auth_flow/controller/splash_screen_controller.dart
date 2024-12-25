import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  RxString splash = RxString('Splash');

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    super.onInit();
  }
}
