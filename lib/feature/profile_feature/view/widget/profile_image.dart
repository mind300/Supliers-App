import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileNameUpdated || current is ProfileImageUpdated,
      builder: (context, state) {
        final isEditing = context.read<ProfileCubit>().isEditing;
        return Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: CustomImageHandler(
                path: context.read<ProfileCubit>().profileImage.isEmpty
                    ? null
                    : context.read<ProfileCubit>().profileImage,
                width: 150.sp,
                fit: BoxFit.cover,
                height: 150.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isEditing) {
                  context.read<ProfileCubit>().pickImage(context);
                }
              },
              child: AnimatedOpacity(
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
            ),
          ],
        );
      },
    );
  }
}
