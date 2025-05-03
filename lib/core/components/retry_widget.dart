import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, this.message, required this.onRetry, this.buttonText});
  final String? message;
  final Function() onRetry;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.h,
          children: [
            Icon(
              Icons.error_rounded,
              size: 100.sp,
              color: Colors.red,
            ),
            Text(
              message ?? "Something went wrong",
            ),
            CustomButton(onPressed: onRetry, text: buttonText ?? "Retry"),
          ],
        ),
      ),
    );
  }
}
