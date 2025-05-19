import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key, required this.currentPage});
  final String currentPage;

  List icons = [
    AppImages.branch,
    AppImages.profile,
    AppImages.manager,
    AppImages.qr,
    AppImages.offer,
    AppImages.cashiers,
    AppImages.history,
    AppImages.password,
    AppImages.about,
  ];

  List titles = [
    'Branch',
    'Profile',
    'Managers',
    'QR Scan',
    'Offers',
    'Cashiers',
    'History',
    "Change Password",
    'About',
  ];

  List route = [
    Routes.branch,
    Routes.profile,
    Routes.manager,
    Routes.qr,
    Routes.offer,
    Routes.cashier,
    Routes.history,
    Routes.changePassword,
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
                    '${CacheHelper.getData(CacheKeys.name)}',
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
                  (index) => _handlePagePermission(
                    page: titles[index],
                    DrawerItemBuilder(
                      title: titles[index],
                      imagePath: icons[index],
                      selectedItem: currentPage,
                      route: route[index],
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                  onPressed: () {
                    CacheHelper.clear();
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

  _handlePagePermission(
    Widget tab, {
    required String page,
  }) {
    var role = CacheHelper.getData(CacheKeys.userType) == "owner"
        ? UsersType.owner
        : CacheHelper.getData(CacheKeys.userType) == "cashier"
            ? UsersType.cashier
            : UsersType.manager;
    // print(role);
    if (role != UsersType.owner && page == 'Branch') {
      return SizedBox();
    }
    // if ((role == UsersType.owner || role == UsersType.manager) &&
    //     page == 'QR Scan') {
    //   return SizedBox();
    // }
    if ((role == UsersType.manager || role == UsersType.cashier) && page == 'Managers') {
      return SizedBox();
    }

    if (role == UsersType.cashier && page == 'Cashiers') {
      return SizedBox();
    }

    return tab;
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
        context.pushNamedAndRemoveAll(
          route,
          arguments: {
            'accountType': ProfileType.personal,
          },
        );
      },
    );
  }
}
