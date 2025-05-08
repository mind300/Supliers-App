import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

class ProfileNameEditor extends StatelessWidget {
  const ProfileNameEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileNameUpdated,
      builder: (context, state) {
        final isEditing = context.read<ProfileCubit>().isEditing;

        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isEditing
                  ? CustomTextFormField(
                      key: const ValueKey('textField'),
                      hintText: "Name",
                      enabled: false,
                      title: "Name",
                      controller: context.read<ProfileCubit>().nameController,
                    )
                  : Text(
                      context.read<ProfileCubit>().nameController.text,
                      key: const ValueKey('textDisplay'),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
            ),
            SizedBox(height: (isEditing ? 10 : 35).h),
          ],
        );
      },
    );
  }
}
