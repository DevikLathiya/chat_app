import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_theme_controller.dart';
import '../../../core/utils/common/image_picker_utils.dart';

class ProfileController extends GetxController{

  var themeController = Get.find<ThemeController>();

  RxDouble ageRange = RxDouble(18);
  RxString gender = RxString("");
  RxString lookingGender = RxString("");

  TextEditingController birthDateController = TextEditingController();
  TextEditingController nameController = TextEditingController(text: 'James Smith');

  RxList<Map<String, dynamic>> imageList = RxList();
  RxList genderList = RxList(["Male","Female","Non - Binary"]);

  pickImage(context) async {
    List<Map<String, dynamic>> files = await MediaPickerUtils().pickMedia(mediaSource: MediaSource.gallery, mediaType: MediaType.image, context: context);

    if (files != null && files.isNotEmpty) {
      imageList!.addAll(files);
    } else {
      debugPrint("No files selected or operation canceled.");
    }
  }

}