// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pocket_trainer/core/constant/app_theme.dart';
// import '../../../module/profile/controller/profile_controller.dart';
// import '../../constant/colors_constants.dart';
// import 'console.dart';
//
// showNewCountryCodeDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return GetX<ProfileController>(
//           init: ProfileController(),
//           builder: (controller) {
//             return AlertDialog(
//                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//                 titlePadding: EdgeInsets.all(12.sp),
//                 insetPadding: EdgeInsets.symmetric(horizontal: 20.sp),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
//                 title: GestureDetector(
//                   onTap: () {
//                     controller.resetCountryData();
//                     Get.back();
//                   },
//                   child: Container(alignment: Alignment.topRight, child: const Icon(Icons.arrow_back)),
//                 ),
//                 content: SizedBox(
//                   height: 450.sp,
//                   width: double.maxFinite,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(
//                         height: 50.sp,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Search country here...",
//                             filled: true,
//                             fillColor: const Color(0xFFF8F5FF),
//                             labelStyle: TextStyle(color: ColorConstant.primary, fontSize: 14.sp, fontWeight: FontWeight.w400),
//                             enabledBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8.sp), borderSide: BorderSide(color: ColorConstant.primary)),
//                             focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8.sp), borderSide: BorderSide(color: ColorConstant.primary)),
//                           ),
//                           onChanged: (value) {
//                             controller.filterItem(value);
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: controller.foundItems.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   Console.debug(controller.foundItems[index], key: "selected country data");
//                                   controller.selectedCountry.value = controller.foundItems[index];
//                                   controller.phoneController.clear();
//                                   controller.formKeyPhone.currentState!.validate();
//                                   Get.back();
//                                   controller.resetCountryData();
//                                 },
//                                 child: Container(
//                                   color: Colors.transparent,
//                                   padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(controller.foundItems[index]["flag"]),
//                                       SizedBox(width: 15.w),
//                                       Expanded(
//                                         child:
//                                             Text("${controller.foundItems[index]["country_en"]}", maxLines: 2, style: Theme.of(context).rethinkSans500.copyWith(fontSize: 16.sp)),
//                                       ),
//                                       SizedBox(width: 5.sp),
//                                       Text("(+${controller.foundItems[index]["phone_code"]})", maxLines: 2, style: Theme.of(context).rethinkSans500.copyWith(fontSize: 13.sp))
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 ));
//           },
//         );
//       });
// }
