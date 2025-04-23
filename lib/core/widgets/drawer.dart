import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  final String selectedItem = 'Branch';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1F54),
            Color(0xFF000C1A),
          ],
        ),
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(28.r),
          bottomEnd: Radius.circular(28.r),
        ),
      ),
      child: SafeArea(
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: CustomImageHandler(path: AppImages.profileTest),
                title: Text(
                  'Muhammad \nkaiian',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItemBuilder(
                title: 'Branch',
                imagePath: AppImages.branch,
                selectedItem: selectedItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItemBuilder extends StatelessWidget {
  const DrawerItemBuilder({
    super.key,
    required this.title,
    required this.imagePath,
    required this.selectedItem,
  });
  final String title;
  final String imagePath;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: CustomImageHandler(
        path: imagePath,
        width: 24.w,
        height: 24.h,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      onTap: () {
        // Update the state of the app
        // ...
        Navigator.pop(context);
      },
    );
  }
}
