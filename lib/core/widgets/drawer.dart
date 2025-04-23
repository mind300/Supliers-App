import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';

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

  List route = [
    Routes.branch,
    Routes.profile,
    Routes.offer,
    Routes.cashier,
    Routes.profile,
    Routes.password,
    Routes.about,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
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
                    route: route[index],
                  ),
                ),
                Spacer(),
                CustomButton(
                  onPressed: () {
                    context.pushNamedAndRemoveAll(
                      Routes.login,
                    );
                  },
                  text: "Log out",
                ),
              ],
            ),
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
    required this.route,
  });
  final String title;
  final String imagePath;
  final String selectedItem;
  final String route;

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
        Navigator.pop(context);
        if (isSelected) {
          return;
        }
        context.pushNamedAndRemoveAll(route);
      },
    );
  }
}
