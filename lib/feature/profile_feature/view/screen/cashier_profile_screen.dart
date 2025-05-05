import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_button.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_related_branch_drop_down.dart';

class CashierProfileScreen extends StatelessWidget {
  const CashierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileDelete) {
          // context.read<ProfileCubit>().toggleEditing();
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog.adaptive(
                icon: Icon(
                  Icons.error,
                  size: 100.sp,
                  color: AppColors.red,
                ),
                // title: const Text('Delete Profile'),
                content:
                    const Text('Are you sure you want to delete this profile?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle delete action
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cashier Profile',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Edit'),
                  onTap: () {
                    context.read<ProfileCubit>().toggleEditing();
                  },
                ),
                PopupMenuItem(
                  child: Text('Delete'),
                  onTap: () {
                    // Handle delete action
                    context.read<ProfileCubit>().deleteProfile();
                  },
                ),
              ];
            }),
          ],
        ),
        drawer: canPop
            ? null
            : AppDrawer(
                currentPage: 'profile',
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(),
              ProfileNameEditor(),
              CustomTextFormField(
                hintText: 'Phone Number',
                title: 'Phone Number',
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: 'Job ID (optional)',
                title: 'Job ID (optional)',
              ),
              SizedBox(height: 10.h),
              // if (isCashier)
              // ProfileRelatedBranchDropDown(),
            ],
          ),
        ),
        bottomNavigationBar: ProfileButton(),
      ),
    );
  }
}
