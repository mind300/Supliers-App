import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';

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
        color: AppColors.red,
      ),
      content: const Text('Do you want to delete the branch?'),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // close dialog
            context.read<BranchDetailsCubit>().deleteBranch(); // trigger delete
          },
          child: Text(
            "Delete",
            style: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
