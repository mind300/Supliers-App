import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/data/model/contant_branch_cashier.dart';
import 'package:supplies/feature/branch_feature/data/model/content.dart';

class BranchDetailsWidget extends StatelessWidget {
  final Content? branch;
  final ContantBranchCashier? branchCashier;
  const BranchDetailsWidget({super.key,  this.branch, this.branchCashier});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      // color: Colors.white,
                      gradient: LinearGradient(
                        colors: AppColors.drawerLinearGradientColor,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(11.sp),
                    child: CustomImageHandler(
                      path: AppImages.branch,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Branch Name:",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          branch!.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        Divider(
                          color: AppColors.dividerColor,
                          thickness: 1,
                        ),
                        Text(
                          "Branch Manager Name:",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          branch?.managerName ?? "None",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              var res = await context.pushNamed(
                Routes.branchDetails,
                arguments: BranchDetailsArguments(
                  branchId: branch!.id!,
                ),
              );
              if (res != null) {
                context.read<BranchCubit>().getBranches();
              }
            },
            child: Container(
              height: 100.h,
              width: 59.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.w,
                ),
              ),
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}

class BranchDetailsArguments {
  final int branchId;
  BranchDetailsArguments({required this.branchId});
}
