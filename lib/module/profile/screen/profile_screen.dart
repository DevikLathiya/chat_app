import 'dart:io';

import 'package:chat_app/core/constant/app_string_constant.dart';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/utils/extension/ext_on_wid.dart';
import 'package:chat_app/module/profile/controller/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors_constants.dart';
import '../../../../core/utils/common/common_textfield.dart';
import '../../../core/constant/image_constants.dart';
import '../../../core/utils/common/common_bottomsheet.dart';
import '../../../core/utils/common/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorConstant.homeScreenColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Text(
                  AppString.profile,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).lato600.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor),
                ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
                Divider(thickness: 1.2.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          controller: controller.nameController,
                          hintText: "Name",
                          fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                          prefix: Image.asset(ImageConstants.profileIcon, scale: 3.5, color: ColorConstant.primary),
                        ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
                        4.h.verticalSpace,
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.photosVideos,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).lato500.copyWith(fontSize: 16.sp, color: ColorConstant.blackColor),
                              ),
                              15.h.verticalSpace,
                              SizedBox(
                                height: 220.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 214.w,
                                      child: controller.imageList.isNotEmpty && controller.imageList[0].isNotEmpty
                                          ? _showImage(controller.imageList[0]['path'])
                                          : _buildDottedContainer(controller, context),
                                    ),
                                    14.h.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                              child: controller.imageList.isNotEmpty && controller.imageList.length > 1
                                                  ? _showImage(controller.imageList[1]['path'])
                                                  : _buildDottedContainer(controller, context)),
                                          14.h.verticalSpace,
                                          Expanded(
                                              child: controller.imageList.isNotEmpty && controller.imageList.length > 2
                                                  ? _showImage(controller.imageList[2]['path'])
                                                  : _buildDottedContainer(controller, context)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              14.h.verticalSpace,
                              SizedBox(
                                height: 104.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: controller.imageList.isNotEmpty && controller.imageList.length > 3
                                            ? _showImage(controller.imageList[3]['path'])
                                            : _buildDottedContainer(controller, context)),
                                    14.h.horizontalSpace,
                                    Expanded(
                                        child: controller.imageList.isNotEmpty && controller.imageList.length > 4
                                            ? _showImage(controller.imageList[4]['path'])
                                            : _buildDottedContainer(controller, context)),
                                    14.h.horizontalSpace,
                                    Expanded(
                                        child: controller.imageList.isNotEmpty && controller.imageList.length > 5
                                            ? _showImage(controller.imageList[5]['path'])
                                            : _buildDottedContainer(controller, context)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.h.verticalSpace,
                        Text(AppString.about, textAlign: TextAlign.center, style: Theme.of(context).lato400.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor))
                            .paddingSymmetric(horizontal: 20.w, vertical: 16.h),
                        _buildAboutLookingTile(controller, context, AppString.gender, AppString.female, ImageConstants.gender).paddingOnly(bottom: 12.h).addGesture(() {
                          genderDialog(controller, context);
                        }),
                        _buildAboutLookingTile(controller, context, AppString.age, '24', ImageConstants.cake).paddingOnly(bottom: 12.h).addGesture(() {
                          birthDateDialog(controller, context);
                        }),
                        _buildAboutLookingTile(controller, context, AppString.location, 'India', ImageConstants.location).paddingOnly(bottom: 12.h),
                        10.h.verticalSpace,
                        Text(
                          AppString.lookingFor,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).lato400.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor),
                        ).paddingSymmetric(horizontal: 20.w, vertical: 16.h),
                        GestureDetector(
                          onTap: () {
                            _lookingGenderDialog(controller, context, controller.themeController.isDarkTheme.value);
                          },
                          child: _buildAboutLookingTile(controller, context, AppString.gender, AppString.female, ImageConstants.gender).paddingOnly(bottom: 12.h),
                        ),
                        GestureDetector(
                            onTap: () {
                              _ageRangeDialog(controller, context);
                            },
                            child: _buildAboutLookingTile(controller, context, AppString.ageRange, '24', ImageConstants.cake).paddingOnly(bottom: 12.h),),
                        _buildAboutLookingTile(controller, context, AppString.language, 'English', ImageConstants.location).paddingOnly(bottom: 12.h),
                        120.h.verticalSpace,
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _showImage(image) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: ClipRRect(borderRadius: BorderRadius.circular(10.r), child: Image.file(File(image), fit: BoxFit.cover)),
    );
  }

  Widget _buildDottedContainer(controller, context) {
    return GestureDetector(
      onTap: () => controller.pickImage(context),
      child: DottedBorder(
        color: ColorConstant.primary,
        borderType: BorderType.RRect,
        radius: Radius.circular(10.r),
        dashPattern: const [6, 6],
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: controller.themeController.isDarkTheme.value ? ColorConstant.primary.withOpacity(0.04) : ColorConstant.primary.withOpacity(0.1),
          ),
          child: Container(
            alignment: Alignment.center,
            height: 26.h,
            width: 26.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.16) : ColorConstant.white,
            ),
            child: Image.asset(ImageConstants.add, height: 12.w, width: 12.w, color: ColorConstant.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutLookingTile(ProfileController controller, context, String title, String subTitle, String image) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(right: 11.w, left: 14.w, top: 15.h, bottom: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration:
          BoxDecoration(color: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.08) : ColorConstant.white, borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 24.w, width: 24.w),
          8.w.horizontalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor : ColorConstant.blackOnly),
          ),
          const Spacer(),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.white : ColorConstant.grey),
          ),
          8.w.horizontalSpace,
          Image.asset(ImageConstants.rightArrow, height: 20.w, width: 20.w, color: ColorConstant.blackColor).paddingOnly(top: 2.h),
        ],
      ),
    );
  }

  void genderDialog(ProfileController controller, context) {
    CommonBottomSheet.getCommonBottomSheet(
        maxHeight: 510.h,
        buttonText: AppString.save,
        onTap: () {
          if (controller.gender.isNotEmpty) {
            Get.back();
          } else {
            CommonToast.toast(msg: "Please select gender", gravity: ToastGravity.CENTER);
          }
        },
        body: Obx(
          () {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppString.gender, style: Theme.of(context).lato700.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor)),
                  5.h.verticalSpace,
                  Text(AppString.selectYourGender, style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
                  24.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => [controller.gender.value = "male", controller.gender.refresh()],
                            child: Container(
                              height: 184.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: controller.gender.value == "male" ? Border.all(color: ColorConstant.primary) : Border.all(color: Colors.transparent)),
                              child: Image.asset(controller.themeController.isDarkTheme.value ? ImageConstants.darkMale : ImageConstants.male),
                            ),
                          ),
                          12.h.verticalSpace,
                          Text(AppString.male, style: Theme.of(context).lato500.copyWith(fontSize: 16.sp, color: ColorConstant.blackColor)),
                        ],
                      ),
                      30.w.horizontalSpace,
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => [controller.gender.value = "female", controller.gender.refresh()],
                            child: Container(
                              height: 184.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: controller.gender.value == "female" ? Border.all(color: ColorConstant.primary) : Border.all(color: Colors.transparent)),
                              child: Image.asset(controller.themeController.isDarkTheme.value ? ImageConstants.darkFemale : ImageConstants.female),
                            ),
                          ),
                          12.h.verticalSpace,
                          Text(AppString.female, style: Theme.of(context).lato500.copyWith(fontSize: 16.sp, color: ColorConstant.blackColor)),
                        ],
                      ),
                    ],
                  ),
                  60.h.verticalSpace,
                ],
              ),
            );
          },
        ));
  }

  void birthDateDialog(ProfileController controller, context) {
    CommonBottomSheet.getCommonBottomSheet(
        buttonText: AppString.save,
        onTap: () {
          if (controller.birthDateController.text.isNotEmpty) {
            Get.back();
          } else {
            CommonToast.toast(msg: "Enter your birth date", gravity: ToastGravity.CENTER);
          }
        },
        body: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppString.birthday, style: Theme.of(context).lato700.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor)),
              5.h.verticalSpace,
              Text(AppString.typeBirthdayDate, style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
              28.h.verticalSpace,
              CommonTextField(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    controller.birthDateController.text = "${date.day}/${date.month}/${date.year}";
                  }
                },
                controller: controller.birthDateController,
                readOnly: true,
                hintText: "DD/MM/YYYY",
                fillColor: controller.themeController.isDarkTheme.value ? Colors.white.withOpacity(0.06) : ColorConstant.greyLite.withOpacity(0.7),
                prefix: Image.asset(ImageConstants.cake, scale: 3.5),
              ),
              40.h.verticalSpace,
            ],
          ),
        ));
  }

  void _lookingGenderDialog(ProfileController controller, context,isDarkTheme) {
    CommonBottomSheet.getCommonBottomSheet(
        maxHeight: 510.h,
        buttonText: AppString.save,
        onTap: () {
          if (controller.lookingGender.isNotEmpty) {
            Get.back();
          } else {
            CommonToast.toast(msg: "Please select gender", gravity: ToastGravity.CENTER);
          }
        },
        body: GetX(
          init: ProfileController(),
          builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppString.gender, style: Theme.of(context).lato700.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor)),
                5.h.verticalSpace,
                Text(AppString.selectLookingGender, style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
                24.h.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                      onTap: () {
                        controller.lookingGender.value = controller.genderList[index];
                        controller.lookingGender.refresh();
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color:
                          controller.themeController.isDarkTheme.value
                              ? controller.lookingGender.value == controller.genderList[index] ? ColorConstant.primary.withOpacity(0.08) : ColorConstant.e3E4BColor
                              : controller.lookingGender.value == controller.genderList[index] ? ColorConstant.lightBlue : ColorConstant.f3f4f6Color,

                          border: Border.all(color: controller.lookingGender.value == controller.genderList[index] ? ColorConstant.primary : Colors.transparent),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                            controller.genderList[index],
                            style: Theme.of(context).lato400.copyWith(fontSize: 16.sp,
                              color: controller.lookingGender.value == controller.genderList[index]
                                  ? ColorConstant.blackColor
                                  : controller.themeController.isDarkTheme.value
                                  ? ColorConstant.hintColor
                                  : ColorConstant.grey,
                            )
                        ),
                      ),
                    ));
                  },
                  separatorBuilder: (context, index) => 16.h.verticalSpace,
                  itemCount: controller.genderList.length,
                ),
                30.h.verticalSpace,
              ],
            ),
          );
        },)
        );
  }

  void _ageRangeDialog(ProfileController controller, context) {
    CommonBottomSheet.getCommonBottomSheet(
        buttonText: AppString.save,
        onTap: () {
          if (controller.ageRange.value == 18) {
            Get.back();
          } else {
            CommonToast.toast(msg: "Select age range", gravity: ToastGravity.CENTER);
          }
        },
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppString.ageRange, style: Theme.of(context).lato700.copyWith(fontSize: 20.sp, color: ColorConstant.blackColor)),
                5.h.verticalSpace,
                Text(AppString.selectAgeRange, style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
                28.h.verticalSpace,
                Row(
                  children: [
                    Text("18", style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackShape: const RectangularSliderTrackShape(),
                          trackHeight: 10.h,

                          thumbColor: ColorConstant.primary,
                        ),
                        child: Slider(
                          value: controller.ageRange.value,
                          label: controller.ageRange.round().toString(),
                          activeColor: ColorConstant.primary,
                          inactiveColor: controller.themeController.isDarkTheme.value ?  ColorConstant.f3f4f6Color.withOpacity(0.10) :  ColorConstant.f3f4f6Color ,
                          min: 18,max: 100,divisions: 88,
                          onChanged: (value) {
                            controller.ageRange.value = value;
                          },
                        ),
                      ),
                    ),
                    Text("100", style: Theme.of(context).lato400.copyWith(fontSize: 16.sp, color: ColorConstant.grey)),
                  ],
                ),
                50.h.verticalSpace,
              ],
            ),
          );
        },)
    );
  }
}
