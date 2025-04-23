import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key, required this.currentPage});
  final String currentPage;

  List icons = [
    AppImages.branch,
    AppImages.profile,
    AppImages.offer,
    AppImages.cashiers,
    AppImages.history,
    AppImages.password,
    AppImages.about,
  ];

  List titles = [
    'Branch',
    'Profile',
    'Offers',
    'Cashiers',
    'History',
    "Password",
    'About',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.drawerLinearGradientColor,
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
              SizedBox(height: 10.h),
              ...List.generate(
                titles.length,
                (index) => DrawerItemBuilder(
                  title: titles[index],
                  imagePath: icons[index],
                  selectedItem: currentPage,
                ),
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
    var isSelected = selectedItem.toLowerCase() == title.toLowerCase();
    return ListTile(
      leading: CustomImageHandler(
        path: imagePath,
        width: 24.w,
        height: 24.h,
        color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.56),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.56),
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
