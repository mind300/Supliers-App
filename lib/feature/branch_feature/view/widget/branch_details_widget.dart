import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';

class BranchDetailsWidget extends StatelessWidget {
  const BranchDetailsWidget({super.key});

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
                          "Branch Address:",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          "11740 San Pablo Ave, El Cerrito, CA 94530",
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
                          "Mohamed Ali",
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
            onTap: () {
              context.pushNamed(Routes.branchDetails);
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
