import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/delete_dialog.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onDeletePressed;

  const ActionButtonsWidget({
    super.key,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
      buildWhen: (previous, current) => current is BranchDetailsEditUpdated,
      builder: (context, state) {
        bool isEditing = context.read<BranchDetailsCubit>().isEditing;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: 25.h,
            child: isEditing
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    key: const ValueKey('CancelButton'),
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
                    key: const ValueKey('ActionButtons'),
                    children: [
                      const Spacer(),
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
                        onTap: onDeletePressed,
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
            SizedBox(width: 5.w),
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
