import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constant/app_string_constant.dart';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/constant/colors_constants.dart';
import 'package:chat_app/core/constant/image_constants.dart';
import 'package:chat_app/module/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/app_theme_controller.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: DashboardScreenController(),
        initState: (state) {
          // state.controller!.addDummyData();
          state.controller!.scrollController = ScrollController();
          state.controller!.scrollController.addListener(state.controller!.scrollListener);;
        },
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorConstant.primary,
            body: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 38.h,
                        width: 38.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.white.withOpacity(0.1)),
                        child: Image.asset(ImageConstants.arrowLeft, height: 22.h),
                      ),
                    ),
                    16.w.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        var cnt = Get.find<ThemeController>();
                        cnt.changeTheme();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 38.h,
                            width: 38.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.white.withOpacity(0.1)),
                            child: Icon(Icons.person, size: 18.h),
                          ),
                          controller.isOnline.value
                              ? Container(height: 8.sp, width: 8.sp, margin: EdgeInsets.only(right: 6.w), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green))
                              : Container(),
                        ],
                      ),
                    ),
                    10.w.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Robert Johnson',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).lato700.copyWith(fontSize: 18.sp, color: ColorConstant.white),
                          ),
                          Text(
                            AppString.online,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).lato400.copyWith(fontSize: 12.sp, color: ColorConstant.blackColor),
                          ),
                        ],
                      ),
                    ),
                    10.w.horizontalSpace,
                    Container(
                      height: 38.h,
                      width: 38.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.white.withOpacity(0.1)),
                      child: Image.asset(ImageConstants.favorite, height: 22.h, width: 22.w),
                    ),
                    7.w.horizontalSpace,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 38.h,
                        width: 38.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.white.withOpacity(0.1)),
                        child: Image.asset(ImageConstants.more, height: 22.h),
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 20.w),
                24.h.verticalSpace,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration:
                        BoxDecoration(color: ColorConstant.scaffoldBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))),
                    child: Column(
                      children: [
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child:
                            // controller.isMessageDelete.value == true ? Center(child: CircularProgressIndicator(color: ColorConstant.primary)) :
                            /*ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    controller: controller.scrollController,
                                    itemCount: controller.getMessageList.length + 1,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (index < controller.getMessageList.length) {
                                        final data = controller.getMessageList[index];
                                        final timestamp = data.createdAt!.toString();
                                        DateTime dateTime = DateTime.parse(timestamp).toLocal();
                                        String apiDate = DateFormat('hh:mm a').format(dateTime);
                                        String formattedDate = dateFormat(dateTime);

                                        return Column(
                                          children: [
                                            // if (index != controller.getMessageList.length - 1) ...[
                                            //   if (getDate(data.createdAt.toString()) != getDate(controller.getMessageList[index + 1].createdAt.toString()))
                                            //     Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey))
                                            //   else
                                            //     const SizedBox.shrink(),
                                            // ] else
                                            //   Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey)).paddingOnly(bottom: 8.h),

                                            ///LeftSide Chat
                                            if (controller.getMessageList[index].senderId != "123")
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  width: Get.width * 7.0,
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 34.h,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.grey),
                                                        child: Image.asset(ImageConstants.dummy)
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            constraints: BoxConstraints(maxWidth: 260.w, minWidth: 60.w),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                                                              color: controller.themeController.isDarkTheme.value
                                                                  ? Colors.white.withOpacity(0.09)
                                                                  : ColorConstant.greyLite,
                                                            ),
                                                            child:  Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  controller.getMessageList[index].message == null
                                                                      ? GestureDetector(
                                                                    onTap: () {
                                                                      // Get.to(
                                                                      //   FullScreenImage(
                                                                      //       images: controller.getMessageList
                                                                      //           .map((message) => message.fileName.toString())
                                                                      //           .toList(),
                                                                      //       initialIndex: index),
                                                                      // );
                                                                    },
                                                                    child: Container(
                                                                      constraints: controller.getMessageList[index].fileName != null
                                                                          ? BoxConstraints(maxHeight: 260.sp, minWidth: 200.sp, maxWidth: 210.sp)
                                                                          : const BoxConstraints(),
                                                                      height: controller.getMessageList[index].fileName == null ? 110.sp : null,
                                                                      width: controller.getMessageList[index].fileName == null ? 185.sp : null,
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color: ColorConstant.grey),
                                                                      child: controller.getMessageList[index].fileName == null
                                                                          ? Center(
                                                                        // child: CommonWidgets.imageAsset(
                                                                        //     image: AppString.galleryImage, height: 24.0, width: 24.0, color: ColorConstant.white)
                                                                      )
                                                                          : ClipRRect(
                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                        child: CachedNetworkImage(
                                                                          fit: BoxFit.cover,
                                                                          imageUrl: controller.getMessageList[index].fileName.toString(),
                                                                          // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                          //     Center(child: CircularProgressIndicator(color: MyColors.bgcolor)),
                                                                          // errorWidget: (context, url, error) =>
                                                                          //     Center(child: Image.asset(AppString.galleryImage, height: 24.sp, width: 24.sp)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                      : controller.getMessageList[index].message!.length <= 125
                                                                      ? Text(
                                                                    controller.getMessageList[index].message.toString(),
                                                                    textAlign: TextAlign.start,
                                                                    style: Theme.of(context).lato400.copyWith(
                                                                      fontSize: 14.sp,
                                                                      color: controller.themeController.isDarkTheme.value
                                                                          ? ColorConstant.hintColor
                                                                          : ColorConstant.grey,
                                                                    ),
                                                                  )
                                                                      : RichText(
                                                                    text: TextSpan(
                                                                      text: data.showLongDes
                                                                          ? '${controller.getMessageList[index].message} ... '
                                                                          : '${controller.getMessageList[index].message.toString().substring(0, 115)} ... ',
                                                                      style: Theme.of(context).lato400.copyWith(
                                                                        fontSize: 14.sp,
                                                                        color: controller.themeController.isDarkTheme.value
                                                                            ? ColorConstant.hintColor
                                                                            : ColorConstant.grey,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                            text: data.showLongDes ? ' ' 'Show less' : 'Show more',
                                                                            recognizer: TapGestureRecognizer()
                                                                              ..onTap = () {
                                                                                data.showLongDes = !data.showLongDes;
                                                                                controller.getMessageList.refresh();
                                                                              },
                                                                            style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.primary))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  controller.getMessageList[index].message != null ? const SizedBox() : SizedBox(height: 4.h),
                                                                  SizedBox(height: 4.h),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 8.h),
                                                          Text(
                                                            apiDate,
                                                            style: Theme.of(context).lato400.copyWith(
                                                                fontSize: 10.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor : ColorConstant.grey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 8.h),

                                            ///Right Side Chat
                                            if (controller.getMessageList[index].senderId == "123")
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      constraints: BoxConstraints(maxWidth: 250.w, minWidth: 60.w),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp), bottomLeft: Radius.circular(20.sp)),
                                                        color: controller.themeController.isDarkTheme.value ? ColorConstant.chatTileColor : ColorConstant.lightBlue,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            controller.getMessageList[index].message == null
                                                                ? GestureDetector(
                                                              onTap: () {
                                                                // Get.to(FullScreenImage(
                                                                //     images: controller.getMessageList
                                                                //         .map((message) => message.fileName.toString())
                                                                //         .toList(),
                                                                //     initialIndex: index));
                                                              },
                                                              child: Container(
                                                                constraints: controller.getMessageList[index].fileName != null
                                                                    ? BoxConstraints(maxHeight: 260.sp, minWidth: 200.sp, maxWidth: 210.sp)
                                                                    : const BoxConstraints(),
                                                                height: controller.getMessageList[index].fileName == null ? 110.sp : null,
                                                                width: controller.getMessageList[index].fileName == null ? 185.sp : null,
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color: ColorConstant.grey),
                                                                child: controller.getMessageList[index].fileName == null
                                                                    ? Center(
                                                                  // child: CommonWidgets.imageAsset(
                                                                  //   image: AppString.galleryImage,
                                                                  //   height: 24.0,
                                                                  //   width: 24.0,
                                                                  //   color: MyColors.white,
                                                                  // ),
                                                                )
                                                                    : ClipRRect(
                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                  child: CachedNetworkImage(
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: controller.getMessageList[index].fileName.toString(),
                                                                    // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                    //     Center(child: CircularProgressIndicator(color: ColorConstant.bgcolor)),
                                                                    // errorWidget: (context, url, error) =>
                                                                    //     Center(child: Image.asset(AppString.galleryImage, height: 24.sp, width: 24.sp)),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : controller.getMessageList[index].message!.length <= 125
                                                                ? Text(
                                                              controller.getMessageList[index].message.toString(),
                                                              textAlign: TextAlign.start,
                                                              style: Theme.of(context).lato400.copyWith(
                                                                fontSize: 14.sp,
                                                                color: controller.themeController.isDarkTheme.value
                                                                    ? ColorConstant.white
                                                                    : ColorConstant.blackOnly,
                                                              ),
                                                            )
                                                                : RichText(
                                                              text: TextSpan(
                                                                text: data.showLongDes
                                                                    ? '${controller.getMessageList[index].message} ... '
                                                                    : '${controller.getMessageList[index].message.toString().substring(0, 115)} ... ',
                                                                style: Theme.of(context).lato400.copyWith(
                                                                  fontSize: 14.sp,
                                                                  color: controller.themeController.isDarkTheme.value
                                                                      ? ColorConstant.white
                                                                      : ColorConstant.blackOnly,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                      text: data.showLongDes ? ' ' 'Show less' : 'Show more',
                                                                      recognizer: TapGestureRecognizer()
                                                                        ..onTap = () {
                                                                          data.showLongDes = !data.showLongDes;
                                                                          controller.getMessageList.refresh();
                                                                        },
                                                                      style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.primary))
                                                                ],
                                                              ),
                                                            ),
                                                            controller.getMessageList[index].message != null ? const SizedBox() : SizedBox(height: 4.h),
                                                            SizedBox(height: 4.h),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      apiDate,
                                                      style: Theme.of(context).lato400.copyWith(
                                                          fontSize: 10.sp, color: controller.themeController.isDarkTheme.value ? ColorConstant.hintColor : ColorConstant.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            SizedBox(height: 10.h),
                                          ],
                                        );
                                      } else {
                                        return controller.dataLoad.value
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 32),
                                                child: Center(child: CircularProgressIndicator(color: ColorConstant.primary)),
                                              )
                                            : const SizedBox();
                                      }
                                    },
                                  ),*/


                            Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                padding: EdgeInsets.only(top: 16.h),
                                controller: controller.scrollController,
                                itemCount: controller.getMessageList.length + 1,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index < controller.getMessageList.length) {
                                    final data = controller.getMessageList[index];
                                    final isOurMessage = data.senderId == "123";

                                    // Check if the next message (previous index in reversed order) is from the same sender
                                    bool isContinuation = false;
                                    if (index + 1 < controller.getMessageList.length) {
                                      isContinuation = controller.getMessageList[index + 1].senderId == data.senderId;
                                    }

                                    // Determine vertical spacing
                                    double verticalSpacing = isContinuation ? 6.h : 10.h;

                                    // if (index != controller.getMessageList.length - 1) ...[
                                    //   if (getDate(data.createdAt.toString()) != getDate(controller.getMessageList[index + 1].createdAt.toString()))
                                    //     Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey))
                                    //   else
                                    //     const SizedBox.shrink(),
                                    // ] else
                                    //   Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey)).paddingOnly(bottom: 8.h),


                                    return Column(
                                      children: [
                                        /// LeftSide Chat
                                        if (!isOurMessage)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: Get.width * 7.0,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 34.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorConstant.grey,
                                                    ),
                                                    child: Image.asset(ImageConstants.dummy),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        constraints: BoxConstraints(maxWidth: 260.w, minWidth: 60.w),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(15.r),
                                                            topRight: Radius.circular(15.r),
                                                            bottomRight: Radius.circular(15.r),
                                                          ),
                                                          color: controller.themeController.isDarkTheme.value
                                                              ? Colors.white.withOpacity(0.09)
                                                              : ColorConstant.greyLite,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                controller.getMessageList[index].message ?? "",
                                                                textAlign: TextAlign.start,
                                                                style: Theme.of(context).lato400.copyWith(
                                                                  fontSize: 14.sp,
                                                                  color: controller.themeController.isDarkTheme.value
                                                                      ? ColorConstant.hintColor
                                                                      : ColorConstant.grey,
                                                                ),
                                                              ),
                                                              SizedBox(height: 4.h),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h),
                                                      Text(
                                                        DateFormat('hh:mm a').format(DateTime.parse(data.createdAt!).toLocal()),
                                                        style: Theme.of(context).lato400.copyWith(
                                                            fontSize: 10.sp,
                                                            color: controller.themeController.isDarkTheme.value
                                                                ? ColorConstant.hintColor
                                                                : ColorConstant.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        /// Right Side Chat
                                        if (isOurMessage)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(maxWidth: 250.w, minWidth: 60.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(15.r),
                                                      bottomRight: Radius.circular(15.r),
                                                      bottomLeft: Radius.circular(15.r),
                                                    ),
                                                    color: controller.themeController.isDarkTheme.value
                                                        ? ColorConstant.chatTileColor
                                                        : ColorConstant.lightBlue,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                                    child: Text(
                                                      controller.getMessageList[index].message ?? "",
                                                      textAlign: TextAlign.start,
                                                      style: Theme.of(context).lato400.copyWith(
                                                        fontSize: 14.sp,
                                                        color: controller.themeController.isDarkTheme.value
                                                            ? ColorConstant.white
                                                            : ColorConstant.blackOnly,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  DateFormat('hh:mm a').format(DateTime.parse(data.createdAt!).toLocal()),
                                                  style: Theme.of(context).lato400.copyWith(
                                                      fontSize: 10.sp,
                                                      color: controller.themeController.isDarkTheme.value
                                                          ? ColorConstant.hintColor
                                                          : ColorConstant.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(height: verticalSpacing),
                                      ],
                                    );
                                  } else {
                                    return controller.dataLoad.value
                                        ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 32),
                                      child: Center(child: CircularProgressIndicator(color: ColorConstant.primary)),
                                    )
                                        : const SizedBox();
                                  }
                                },
                              ),
                            )

                          ),
                        ),

                        controller.isImageLoad.value
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color: ColorConstant.grey.withOpacity(0.6)),
                                      child: Center(child: CircularProgressIndicator(color: ColorConstant.primary)),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        ///Edit Text Field
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                // height: 46.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                    color: ColorConstant.chatTextFiled,
                                    border: Border.all(color: ColorConstant.grey)
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // controller.getMultipleFile();
                                      },
                                      child: Center(child: Image.asset(ImageConstants.emoji, width: 24.h, height: 24.w,color: controller.themeController.isDarkTheme.value ? null : ColorConstant.grey)),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          //   controller.socketController.typingMessage(
                                          //       senderId: myRegisterUserId,
                                          //       roomId: controller.roomId.value,
                                          //       firstName: controller.name.value,
                                          //       lastName: controller.userName.value);
                                        },
                                        controller: controller.messageInputController,
                                        style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.blackColor),
                                        textInputAction: TextInputAction.newline,
                                        maxLines: 3,
                                        minLines: 1,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none, hintText: 'Write your message...', hintStyle: TextStyle(fontFamily: "outfit_regular")),
                                      ),
                                    ),
                                    Center(child: Image.asset(ImageConstants.document, width: 20.h, height: 20.w,color: controller.themeController.isDarkTheme.value ? null : ColorConstant.grey)),
                                    SizedBox(width: 12.w),
                                    Center(child: Image.asset(ImageConstants.camera, width: 24.h, height: 24.w,color: controller.themeController.isDarkTheme.value ? null : ColorConstant.grey)),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                if (controller.messageInputController.text.trim().isNotEmpty) {
                                  // controller.socketController.sendTexMessage(
                                  //     userId: myRegisterUserId,
                                  //     receiverId: controller.getReceiverId.value,
                                  //     msg: controller.messageInputController.text.trim(),
                                  //     roomId: controller.roomId.value);
                                }
                                controller.messageInputController.clear();
                              },
                              child: Container(
                                height: 46.h,
                                width: 46.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.primary),
                                child: Image.asset(ImageConstants.send, width: 24.h, height: 24.w),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  String dateFormat(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else {
      final formatter = DateFormat('MMMM d');
      return formatter.format(date);
    }
  }

  String getDate(String date) {
    String string = date;
    final splitted = string.split('T');
    return splitted[0];
  }
}
