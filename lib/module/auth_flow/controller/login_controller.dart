import "package:flutter/cupertino.dart";
import "package:get/get.dart";
import "package:get/get_rx/get_rx.dart";
import "../../../app_controller/app_controller.dart";
import "../../../core/constant/app_theme_controller.dart";
import "../../../core/constant/country_data.dart";
import "../../../core/utils/common/common_widgets.dart";
import "../../../services/api/api_repository.dart";

class LoginController extends GetxController {

  var themeController = Get.find<ThemeController>();

  RxMap<String, dynamic> selectedCountry = RxMap();
  RxList<Map<String, dynamic>> foundItems = RxList<Map<String, dynamic>>([]);

  TextEditingController enterFirstName = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  RxBool isNameEntered = RxBool(true);
  RxBool isGenderEntered = RxBool(false);
  RxBool isDateEntered = RxBool(false);
  RxString gender = RxString("");

  @override
  void onInit() {
    super.onInit();
    foundItems.value = countryList;
  }



  Future<void> onLogin() async {
    // LoginPayload loginPayload = LoginPayload(
    //   email: emailController.value.text.toLowerCase().trim(),
    //   password: passwordController.value.text.trim(),
    // );
    //
    // LoginResponse? loginResponse = await ApiRepository.loginApi(loginPayload.toMap());
    // if (loginResponse != null) {
    //   appController.storeUserInfo(loginResponse.toMap());
    //   Get.offAllNamed(RoutesStrings.bottomNavigationRoute);
    // }
  }

  resetCountryData() {
    foundItems.value = countryList;
  }

}
