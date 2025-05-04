import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
      buildWhen: (previous, current) => current is BranchDetailsEditUpdated,
      builder: (context, state) {
        bool isEditing = context.read<BranchDetailsCubit>().isEditing;

        // Animation of the action buttons
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: 25.h,
            child: isEditing
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    key: ValueKey('CancelButton'),
                    child: GestureDetector(
                      onTap: () {
                        context.read<BranchDetailsCubit>().toggleEditing();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  )
                : Row(
                    key: ValueKey('ActionButtons'),
                    children: [
                      Spacer(),
                      actionButton(
                        title: 'Edit',
                        icon: AppImages.edit,
                        onTap: () {
                          context.read<BranchDetailsCubit>().toggleEditing();
                        },
                        color: AppColors.primaryDark,
                      ),
                      SizedBox(width: 5.w),
                      actionButton(
                        title: 'Delete',
                        icon: AppImages.edit,
                        color: AppColors.redDark,
                        onTap: () {
                          context.read<BranchDetailsCubit>().deleteBranch();
                        },
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget actionButton({
    required VoidCallback onTap,
    required String title,
    required String icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            CustomImageHandler(
              path: icon,
              width: 11.w,
              height: 11.h,
            ),
          ],
        ),
      ),
    );
  }
}
