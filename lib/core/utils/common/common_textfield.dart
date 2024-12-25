import 'package:chat_app/core/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/colors_constants.dart';
import '../../constant/image_constants.dart';
import 'common_props.dart';

class CommonSearchTextField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Color? fillColor;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CommonSearchTextField({
    super.key,
    this.hintText,
    this.onChanged,
    required this.controller,
    this.prefixIcon,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
          fillColor: fillColor ?? ColorConstant.white,
          errorStyle: TextStyle(fontSize: 0.sp, color: ColorConstant.transparent),
          hintText: hintText ?? "",
          hintStyle: Theme.of(context).lato400.copyWith(color: ColorConstant.hintColor, fontSize: 16.sp),
          border: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          disabledBorder: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          enabledBorder: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          errorBorder: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          focusedBorder: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          focusedErrorBorder: CommonProps.textFieldWhiteBorder(12.sp, ColorConstant.grey.withOpacity(0.2)),
          prefixIcon: prefixIcon,
        ),
        cursorColor: ColorConstant.primary,
        style: Theme.of(context).lato400.copyWith(color: ColorConstant.blackColor),
      ),
    );
  }
}

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final int? maxLines;
  final int? maxLengthInput;
  final Color? hintTextColor;
  final Color? fillColor;
  final TextInputType? textInputType;
  final TextInputFormatter? filteringTextInputFormatter;
  final String? Function(String?)? validation;
  final bool? readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;

  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.prefix,
    this.suffix,
    this.textInputType,
    this.obscureText = false,
    this.maxLines,
    this.validation,
    this.maxLengthInput,
    this.filteringTextInputFormatter,
    this.hintTextColor,
    this.fillColor,
    this.readOnly,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Text(
                labelText ?? "",
                style: Theme.of(context).lato400.copyWith(fontSize: 14.sp, color: ColorConstant.appTxtColor),
              )
            : const SizedBox(),
        labelText != null ? SizedBox(height: 8.h) : const SizedBox(),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLengthInput,
          inputFormatters: [
            ...(filteringTextInputFormatter != null ? [filteringTextInputFormatter!] : []),
          ],
          keyboardType: textInputType ?? TextInputType.text,
          validator: validation,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            errorMaxLines: 4,
            counterText: "",
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
            fillColor: fillColor ?? ColorConstant.white,
            errorStyle: Theme.of(context).lato400.copyWith(fontSize: 12.sp, color: ColorConstant.transparent),
            hintText: hintText ?? "",
            hintStyle: Theme.of(context).lato400.copyWith(color: ColorConstant.hintColor, fontSize: 16.sp),
            border: CommonProps.textFieldWhiteBorder(12.sp, fillColor),
            disabledBorder: CommonProps.textFieldWhiteBorder(12.sp, fillColor),
            enabledBorder: CommonProps.textFieldWhiteBorder(12.sp, fillColor),
            focusedBorder: CommonProps.textFieldWhiteBorder(12.sp, fillColor),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.sp), borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.sp), borderSide: const BorderSide(color: Colors.red)),
            suffixIcon: suffix,
            prefixIcon: prefix,
            enabled: true,
          ),
          cursorColor: ColorConstant.primary,
          obscureText: obscureText,
          style: Theme.of(context).lato400.copyWith(color: ColorConstant.blackColor),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
