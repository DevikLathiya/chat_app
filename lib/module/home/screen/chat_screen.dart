import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constant/app_string_constant.dart';
import 'package:chat_app/core/constant/app_theme.dart';
import 'package:chat_app/core/constant/colors_constants.dart';
import 'package:chat_app/core/constant/image_constants.dart';
import 'package:chat_app/module/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: DashboardScreenController(),
        initState: (state) {
          state.controller!.addDummyData();
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
                    Stack(
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
                            child: controller.isMessageDelete.value == true
                                ? Center(child: CircularProgressIndicator(color: ColorConstant.primary))
                                : ListView.builder(
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
                                            if (index != controller.getMessageList.length - 1) ...[
                                              if (getDate(data.createdAt.toString()) != getDate(controller.getMessageList[index + 1].createdAt.toString()))
                                                Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey))
                                              else
                                                const SizedBox.shrink(),
                                            ] else
                                              Text(formattedDate, style: Theme.of(context).lato500.copyWith(fontSize: 14.sp, color: ColorConstant.grey)),

                                            ///LeftSide Chat
                                            if (controller.getMessageList[index].senderId != "123")
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  width: Get.width * 7.0,
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 24.h,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.grey),
                                                        child: Image.asset(ImageConstants.dummy)
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Container(
                                                        constraints: const BoxConstraints(maxWidth: 300, minWidth: 60),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                                                            color: ColorConstant.greyLite),
                                                        child: Stack(
                                                          children: [
                                                            ///TextPart
                                                            Flex(
                                                              direction: Axis.vertical,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                                                                              ? Text(controller.getMessageList[index].message.toString(),
                                                                          textAlign: TextAlign.start,
                                                                          style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.grey)
                                                                      )
                                                                              : RichText(
                                                                                  text: TextSpan(
                                                                                    text: data.showLongDes
                                                                                        ? '${controller.getMessageList[index].message} ... '
                                                                                        : '${controller.getMessageList[index].message.toString().substring(0, 115)} ... ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 15.sp,
                                                                                        color: ColorConstant.primary,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        fontFamily: "outfit_medium"),
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: data.showLongDes ? ' ' 'Show less' : 'Show more',
                                                                                        recognizer: TapGestureRecognizer()
                                                                                          ..onTap = () {
                                                                                            data.showLongDes = !data.showLongDes;
                                                                                            controller.getMessageList.refresh();
                                                                                          },
                                                                                        style: TextStyle(
                                                                                            color: Colors.blue,
                                                                                            decoration: TextDecoration.underline,
                                                                                            fontSize: 13.sp,
                                                                                            fontFamily: "outfit_medium"),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                      controller.getMessageList[index].message != null ? const SizedBox() : SizedBox(height: 4.h),
                                                                      SizedBox(height: 8.h),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(height: 4.h),
                                                              ],
                                                            ),
                                                            Positioned(
                                                              bottom: 5,
                                                              left: 5,
                                                              child: Text(apiDate, style: Theme.of(context).lato400.copyWith(fontSize: 10.sp, color: ColorConstant.grey)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
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
                                                  children: [
                                                    Container(
                                                      constraints: const BoxConstraints(maxWidth: 300, minWidth: 60),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp), bottomLeft: Radius.circular(20.sp)),
                                                        color: ColorConstant.e3E4BColor,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          ///TextPart
                                                          Flex(
                                                            direction: Axis.vertical,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                                                                            ? Text(controller.getMessageList[index].message.toString(),
                                                                                textAlign: TextAlign.start,
                                                                                style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.white))
                                                                            : RichText(
                                                                                text: TextSpan(
                                                                                  text: data.showLongDes
                                                                                      ? '${controller.getMessageList[index].message} ... '
                                                                                      : '${controller.getMessageList[index].message.toString().substring(0, 115)} ... ',
                                                                                  style: Theme.of(context).lato400.copyWith(fontSize: 13.sp, color: ColorConstant.primary),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                        text: data.showLongDes ? ' ' 'Show less' : 'Show more',
                                                                                        recognizer: TapGestureRecognizer()
                                                                                          ..onTap = () {
                                                                                            data.showLongDes = !data.showLongDes;
                                                                                            controller.getMessageList.refresh();
                                                                                          },
                                                                                        style: Theme.of(context).lato400.copyWith(fontSize: 13.sp, color: ColorConstant.primary))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                    controller.getMessageList[index].message != null ? const SizedBox() : SizedBox(height: 4.h),
                                                                    SizedBox(height: 8.h),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 4.h),
                                                            ],
                                                          ),
                                                          Positioned(
                                                            bottom: 5,
                                                            right: 5,
                                                            child: Text(apiDate, style: Theme.of(context).lato400.copyWith(fontSize: 10.sp, color: ColorConstant.grey)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
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
                                  ),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: ColorConstant.white, border: Border.all(color: ColorConstant.grey)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // controller.getMultipleFile();
                                        },
                                        child: Container(
                                          height: 40.sp,
                                          width: 40.sp,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.chatTextFiled),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Icon(Icons.emoji_emotions),
                                          ),
                                        ),
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
                                      Container(
                                        height: 40.sp,
                                        width: 40.sp,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.grey),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(Icons.emoji_emotions),
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
                                          height: 40.sp,
                                          width: 40.sp,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.grey),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Image.asset(ImageConstants.send, width: 20.sp, height: 20.sp),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
