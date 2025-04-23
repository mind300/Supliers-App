import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text__form_field.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/widgets/drawer.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(currentPage: 'password'),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
        child: Column(
          spacing: 10.h,
          children: [
            CustomTextFormField(
              hintText: 'Current Password',
              title: 'Current Password',
              suffixIcon: Padding(
                padding: EdgeInsets.all(13.sp),
                child: CustomImageHandler(path: AppImages.closeEye),
              ),
            ),
            CustomTextFormField(
              hintText: 'New Password',
              title: 'New Password',
              suffixIcon: Padding(
                padding: EdgeInsets.all(13.sp),
                child: CustomImageHandler(path: AppImages.closeEye),
              ),
            ),
            CustomTextFormField(
              hintText: 'Confirm New Password',
              title: 'Confirm New Password',
              suffixIcon: Padding(
                padding: EdgeInsets.all(13.sp),
                child: CustomImageHandler(path: AppImages.closeEye),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: CustomButton(
          onPressed: () {},
          text: 'Change Password',
        ),
      ),
    );
  }
}
