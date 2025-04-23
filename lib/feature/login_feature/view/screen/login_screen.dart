import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text__form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(26.sp),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35.h),
            CustomImageHandler(
              path: AppImages.logoH,
              width: 200.w,
              height: 150.h,
            ),
            SizedBox(height: 20.h),
            Text(
              'Log in',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTitleColor,
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Please enter your email and password to ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.authSubTitleColor,
                ),
                children: [
                  TextSpan(
                    text: 'log in',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              title: "Email",
              hintText: "Enter your email address",
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              title: "Password",
              hintText: "Enter your password",
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.sp),
                child: CustomImageHandler(path: AppImages.closeEye),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "Forget password?",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () {
                context.pushNamedAndRemoveAll(
                  Routes.branch,
                  // arguments: {
                  //   "canAdd": true,
                  // },
                );
              },
              text: "Log in",
            ),
          ],
        ),
      ),
    );
  }
}
