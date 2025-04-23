import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileNameUpdated,
      builder: (context, state) {
        final isEditing = context.read<ProfileCubit>().isEditing;

        return Stack(
          alignment: Alignment.center,
          children: [
            CustomImageHandler(
              path: AppImages.profileTest,
              width: 150.w,
              height: 150.h,
            ),
            AnimatedOpacity(
              opacity: isEditing ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.72),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
