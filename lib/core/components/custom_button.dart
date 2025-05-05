import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.backgroundColor = AppColors.primary,
    this.icon,
    this.borderColor = AppColors.primary,
    this.color,
    this.width,
    this.enabled = true,
    this.leading,
    this.height,
  });
  final VoidCallback onPressed;
  final String? text;
  final Widget? icon;
  final Color borderColor;
  final double? width;
  final Color? color;
  final Color backgroundColor;
  final bool enabled;
  final dynamic? leading;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 54.sp,
        decoration: BoxDecoration(
          border: Border.all(
            color: enabled ? borderColor : borderColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.primary.withOpacity(0.2),
          //     blurRadius: 10,
          //     offset: const Offset(0, 5),
          //   ),
          // ],
        ),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            backgroundColor:
                enabled ? backgroundColor : backgroundColor.withOpacity(0.5),
          ),
          onPressed: enabled ? onPressed : () {},
          icon: leading == null
              ? null
              : CustomImageHandler(
                  path: leading,
                  height: 20.sp,
                  width: 20.sp,
                  color: color ?? AppColors.white,
                ),
          label: icon != null
              ? icon!
              : FittedBox(
                  child: Text(
                    text.toString(),
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.bold,
                      color: color ?? AppColors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
