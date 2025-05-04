import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/constant/app_colors.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: Icon(
        Icons.info_outline,
        size: 75.sp,
      ),
      content: Text('Do you want to delete the branch?'),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        CustomButton(
          onPressed: () {},
          text: "Delete",
          backgroundColor: AppColors.red,
          borderColor: AppColors.red,
        ),
        CustomButton(
          height: 35.h,
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Cancel",
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          color: AppColors.black,
        ),
      ],
    );
  }
}
