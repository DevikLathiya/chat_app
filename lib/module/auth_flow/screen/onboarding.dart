import 'package:chat_app/core/constant/app_string_constant.dart';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/constant/colors_constants.dart';
import 'package:chat_app/core/constant/image_constants.dart';
import 'package:chat_app/core/utils/common/common_bottomsheet.dart';
import 'package:chat_app/core/utils/common/common_textfield.dart';
import 'package:chat_app/module/auth_flow/controller/login_controller.dart';
import 'package:chat_app/module/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_theme_controller.dart';
import '../../../core/utils/common/common_widgets.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: LoginController(),
      builder: (controller) {
        controller.selectedCountry.value;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorConstant.scaffoldBackground,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.statusBarHeight + 15.h),
              Text(
                'Logo',
                textAlign: TextAlign.center,
                style: Theme.of(context).lato700.copyWith(fontSize: 24.sp, color: ColorConstant.primary),
              ),
              38.h.verticalSpace,
              SizedBox(width: Get.width, child: Image.asset(controller.themeController.isDarkTheme.value ? ImageConstants.getStartedDark:ImageConstants.getStarted, height: 306.h, width: 310.w)),
              50.h.verticalSpace,
              Text(AppString.discoverYourPerfectMatchNearby, textAlign: TextAlign.center, style: Theme.of(context).lato700.copyWith(fontSize: 28.sp)),
              22.h.verticalSpace,
              Text(
                AppString.connectChatAndFind,
                textAlign: TextAlign.center,
                style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // var cnt = Get.find<ThemeController>();
                  // cnt.changeTheme();

                  dateDialog(controller,context);
                  // enterNameDialog(controller,context);
                },
                child: Container(
                  height: 60.h,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: ColorConstant.primary, borderRadius: BorderRadius.circular(16.r)),
                  child: Text(AppString.getStarted, style: Theme.of(context).lato600.copyWith(fontSize: 18.sp, color: ColorConstant.white)),
                ),
              ),
              22.h.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 20.w),
        );
      }
    );
  }

  selectCountiesDialog(LoginController controller,context){
    CommonBottomSheet.getCommonBottomSheet(
      maxHeight: 600.h,
      title: AppString.selectCountry,
      buttonText: AppString.next,
      onTap: () {

        // var cnt = Get.find<ThemeController>();
        // cnt.changeTheme();
        if(controller.selectedCountry.isNotEmpty){
          Get.back();
          enterNameDialog(controller,context);
        }
        else{
          CommonToast.toast(msg: "Please select country",gravity: ToastGravity.CENTER);
        }
      },
      body: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.foundItems.length,
        separatorBuilder: (context, index) => const Divider().paddingSymmetric(vertical: 10.h),
        itemBuilder: (BuildContext context, int index) {
          return Obx(() => GestureDetector(
            onTap: () {
              controller.selectedCountry.value = controller.foundItems[index];
              controller.selectedCountry.refresh();
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(controller.selectedCountry == controller.foundItems[index] ? ImageConstants.fillCircle :ImageConstants.circle,height: 20.w,width: 20.w,
                    color: controller.selectedCountry == controller.foundItems[index] ? ColorConstant.primary : controller.themeController.isDarkTheme.value ? ColorConstant.hintColor.withOpacity(0.4) :ColorConstant.greyLite
                  ),
                  SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "${controller.foundItems[index]["country_en"]}",
                        maxLines: 2,
                        style: Theme.of(context).lato400.copyWith(
                              fontSize: 16.sp,
                              color: controller.selectedCountry == controller.foundItems[index] ? ColorConstant.blackColor : ColorConstant.grey,
                            ),
                      ),
                    ),
                  ],
              ),
            ),
          ),);
        },),
    );
  }

  enterNameDialog(LoginController controller,context){
   CommonBottomSheet.getCommonBottomSheet(
        // maxHeight: 510.h,
        buttonText: AppString.next,
        onTap: () {
          if(controller.enterFirstName.text.isNotEmpty){
            controller.isGenderEntered.value = true;
            controller.isGenderEntered.refresh();
            Get.back();
            genderDialog(controller, context);
          }
          else{
            CommonToast.toast(msg: "Enter your name",gravity: ToastGravity.CENTER);
          }
        },
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildStepperRow(controller, context),

                  Text(AppString.whatsYourFirstName,
                      style: Theme.of(context).lato700.copyWith(fontSize: 20.sp,color: ColorConstant.blackColor)
                  ),
                  20.h.verticalSpace,
                  CommonSearchTextField(
                    controller: controller.enterFirstName,
                    hintText: "Robert Smith",
                    fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.06) : ColorConstant.greyLite.withOpacity(0.7),
                    prefixIcon: Image.asset(ImageConstants.user,scale: 3.5),
                  ),

                60.h.verticalSpace,
              ],
            ),
          );
        },)
      );
  }

  genderDialog(LoginController controller,context){
   CommonBottomSheet.getCommonBottomSheet(
        maxHeight: 510.h,
        buttonText: AppString.next,
        onTap: () {
          if (controller.gender.isNotEmpty) {
            controller.isDateEntered.value = true;
            Get.back();
            dateDialog(controller, context);
          } else {
            CommonToast.toast(msg: "Please select gender", gravity: ToastGravity.CENTER);
          }
        },
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildStepperRow(controller, context),

                if(controller.isNameEntered.value && !controller.isGenderEntered.value && !controller.isDateEntered.value)
                  Column(
                    children: [
                      Text(AppString.whatsYourFirstName,
                          style: Theme.of(context).lato700.copyWith(fontSize: 20.sp,color: ColorConstant.blackColor)
                      ),
                      20.h.verticalSpace,
                      CommonSearchTextField(
                        controller: controller.enterFirstName,
                        hintText: "Robert Smith",
                        fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.06) : ColorConstant.greyLite.withOpacity(0.7),
                        prefixIcon: Image.asset(ImageConstants.user,scale: 4),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text(AppString.whatsYourGender,
                          style: Theme.of(context).lato700.copyWith(fontSize: 20.sp,color: ColorConstant.blackColor)
                      ),
                      26.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => [controller.gender.value = "male",controller.gender.refresh()],
                                child: Container(
                                  height: 184.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: controller.gender.value == "male" ? Border.all(color: ColorConstant.primary) : Border.all(color: Colors.transparent)
                                  ),
                                  child: Image.asset(controller.themeController.isDarkTheme.value ? ImageConstants.darkMale : ImageConstants.male),
                                ),
                              ),
                              12.h.verticalSpace,
                              Text(AppString.male,
                                  style: Theme.of(context).lato500.copyWith(fontSize: 16.sp,color: ColorConstant.blackColor)
                              ),
                            ],
                          ),
                          30.w.horizontalSpace,
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => [controller.gender.value = "female",controller.gender.refresh()],
                                child: Container(
                                  height: 184.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: controller.gender.value == "female" ? Border.all(color: ColorConstant.primary) : Border.all(color: Colors.transparent)
                                  ),
                                  child: Image.asset(controller.themeController.isDarkTheme.value ? ImageConstants.darkFemale : ImageConstants.female),
                                ),
                              ),
                              12.h.verticalSpace,
                              Text(AppString.female,
                                  style: Theme.of(context).lato500.copyWith(fontSize: 16.sp,color: ColorConstant.blackColor)
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),


                60.h.verticalSpace,
              ],
            ),
          );
        },)
      );
  }

  dateDialog(LoginController controller,context){
    CommonBottomSheet.getCommonBottomSheet(
        buttonText: AppString.next,
        onTap: () {
          if(controller.birthDateController.text.isNotEmpty){
            Get.back();
            Get.to(BottomNavigationBarUI());
          }
          else{
            CommonToast.toast(msg: "Enter your birth date",gravity: ToastGravity.CENTER);
          }
        },
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepperRow(controller, context),

                Text(AppString.whatsYourBirthDate,
                    style: Theme.of(context).lato700.copyWith(fontSize: 20.sp,color: ColorConstant.blackColor)
                ),
                20.h.verticalSpace,
                CommonTextField(
                  onTap: () async {
                    DateTime? date= await showDatePicker(
                        context: context,
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now(),
                      );
                    if(date!= null){
                      controller.birthDateController.text = "${date.day}/${date.month}/${date.year}";
                    }
                    },
                  controller: controller.birthDateController,
                  readOnly: true,
                  hintText: "DD/MM/YYYY",
                  fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.06) : ColorConstant.greyLite.withOpacity(0.7),
                  prefix: Image.asset(ImageConstants.cake,scale: 3.5),
                ),

                60.h.verticalSpace,
              ],
            ),
          );
        },)
    );
  }

  Widget _buildStepperRow(LoginController controller,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        18.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepper(controller.isNameEntered.value,controller),
            _buildConnectorLine(controller.isGenderEntered.value,controller),
            _buildStepper(controller.isGenderEntered.value,controller),
            _buildConnectorLine(controller.isDateEntered.value,controller),
            _buildStepper(controller.isDateEntered.value,controller),
          ],
        ),
        4.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildText("${AppString.step} 1", controller.isNameEntered.value, context),
            _buildText("${AppString.step} 2", controller.isGenderEntered.value, context),
            _buildText("${AppString.step} 3", controller.isDateEntered.value, context),
          ],
        ),
        36.h.verticalSpace,
      ],
    );
  }

  Widget _buildStepper(bool isActive,LoginController controller) {
    return Image.asset(isActive ? ImageConstants.fillCircle : ImageConstants.circle,height: 24.w,width: 24.w,color:  isActive ? ColorConstant.primary : controller.themeController.isDarkTheme.value ? ColorConstant.hintColor.withOpacity(0.4) :ColorConstant.greyLite);
  }

  Widget _buildConnectorLine(bool isActive,LoginController controller) {
    return Container(height: 1.h,width: 76.h,color: isActive ? ColorConstant.primary : controller.themeController.isDarkTheme.value ? ColorConstant.hintColor.withOpacity(0.4) : ColorConstant.greyLite);
  }

  Widget _buildText(String text,bool isActive,context) {
    return Text(text, style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: isActive ? ColorConstant.blackColor : ColorConstant.blackColor.withOpacity(0.6)));
  }
}
