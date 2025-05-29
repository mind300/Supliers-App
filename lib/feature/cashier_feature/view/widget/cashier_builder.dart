import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/feature/cashier_feature/controller/cashiers_cubit.dart';
import 'package:supplies/feature/manager_feature/controller/managers_cubit.dart';

class EmployeeDataBuilder extends StatelessWidget {
  const EmployeeDataBuilder({
    super.key,
    this.image,
    this.name,
    this.id,
    this.userType,
    this.subtitle,
    this.onDeletePressed,
  });
  final String? image;
  final String? name;
  final String? id;
  final UsersType? userType;
  final String? subtitle;
  final Function? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Color(0xff544c4c24).withOpacity(0.14),
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
        onTap: () async {
          if (onDeletePressed != null) {
            onDeletePressed!();
            return;
          }
          if (CacheHelper.getData(CacheKeys.userType) == 'cashier') {
            return;
          }
          if (CacheHelper.getData(CacheKeys.userType) == 'manager') {
            if (userType == UsersType.cashier) {
              var res = await context.pushNamed(
                Routes.cashierProfile,
                arguments: {
                  "id": id,
                },
              );
              if (res != null) {
                context.read<CashiersCubit>().getCashiers();
              }
            }
          }
          if (CacheHelper.getData(CacheKeys.userType) == 'owner') {
            if (userType == UsersType.cashier) {
              var res = await context.pushNamed(
                Routes.cashierProfile,
                arguments: {
                  "id": id,
                },
              );
              if (res != null) {
                context.read<CashiersCubit>().getCashiers();
              }
            } else if (userType == UsersType.manager) {
              var res = await context.pushNamed(
                Routes.managerProfile,
                arguments: {
                  "id": id,
                },
              );
              if (res != null) {
                context.read<ManagersCubit>().getManagers();
              }
            }
          }
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        leading: ClipOval(
            child: CustomImageHandler(
          path: image,
          width: 50.sp,
          height: 50.sp,
          fit: BoxFit.cover,
        )),
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
        trailing: (CacheHelper.getData(CacheKeys.userType) == 'manager' && userType == UsersType.manager) || CacheHelper.getData(CacheKeys.userType) == 'cashier'
            ? null
            : Icon(
                onDeletePressed != null ? Icons.delete : Icons.arrow_forward_ios,
              ),
      ),
    );
  }
}
