import 'package:flutter/material.dart';
import 'package:vetcurekartchat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// 输入框
Widget inputTextEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  TextAlign? textAlign = TextAlign.start,
  bool isPassword = false,
  bool readOnly = false,
  double marginTop = 15,
  double height = 44,
  bool autofocus = false,
  Widget? ClearWidget,
  VoidCallback? onPressed,
  ValueChanged<String>? onchanged,
}) {
  return Container(
    height: height.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.secondaryElement,
      borderRadius: Radii.k6pxRadius,
    ),
    child: TextField(
      scrollPadding:EdgeInsets.zero,
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: ClearWidget,
        hintStyle:TextStyle(color: AppColors.thirdElementText),
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        isDense: true,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      maxLines: 1,
      textAlign:textAlign??TextAlign.start,
      autocorrect: false, // 自动纠正
      readOnly: readOnly, //
      obscureText: isPassword, // 隐藏输入内容, 密码框
      onTap: onPressed,
      onChanged: onchanged,
    ),
  );
}

Widget inputTextAreaEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
  ValueChanged<String>? onchanged,
}) {
  return Container(
    height: 100.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.secondaryElement,
      borderRadius: Radii.k6pxRadius,
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:TextStyle(color: AppColors.thirdElementText),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      maxLines: 3,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
      onChanged: onchanged,
    ),
  );
}

/// email 输入框
/// 背景白色，文字黑色，带阴影
Widget inputEmailEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      borderRadius: Radii.k6pxRadius,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(41, 0, 0, 0),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.primaryText,
        ),
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}

