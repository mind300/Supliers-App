import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key,
      this.icon,
      required this.onPressed,
      this.iconColor = AppColors.white});
  final dynamic icon;
  final Function() onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(360.r),
      ),
      backgroundColor: AppColors.primary,
      child: CustomImageHandler(
        path: icon,
        width: 24.w,
        height: 24.h,
        color: iconColor,
      ),
    );
  }
}
