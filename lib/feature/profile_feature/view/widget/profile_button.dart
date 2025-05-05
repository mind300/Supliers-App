import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileNameUpdated,
      builder: (context, state) {
        final isEditing = context.read<ProfileCubit>().isEditing;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: CustomButton(
            onPressed: () {
              if (isEditing) {
                context.read<ProfileCubit>().editProfile();
              } else
                context.read<ProfileCubit>().toggleEditing();
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Text(
                isEditing ? "Save" : "Edit",
                key: ValueKey(isEditing),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
