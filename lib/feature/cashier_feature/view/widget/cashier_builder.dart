import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';

class EmployeeDataBuilder extends StatelessWidget {
  const EmployeeDataBuilder({
    super.key,
    this.image,
    this.name,
    this.id,
    this.userType,
    this.subtitle,
  });
  final String? image;
  final String? name;
  final String? id;
  final UsersType? userType;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Color(0xFF544C4C24).withOpacity(0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if (userType == UsersType.cashier) {
            context.pushNamed(
              Routes.cashierProfile,
              arguments: {
                "id": id,
              },
            );
          } else if (userType == UsersType.manager) {
            context.pushNamed(
              Routes.managerProfile,
              arguments: {
                "id": id,
              },
            );
          }
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        leading: ClipOval(
          child: image != null && image!.isNotEmpty
              ? CustomImageHandler(
                  path: image!,
                  width: 50.sp,
                  height: 50.sp,
                  fit: BoxFit.cover,
                )
              : CustomImageHandler(
                  path: AppImages.profileTest,
                ),
        ),
        title: Text(
          // "Mohamed Ali",
          name ?? "",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
