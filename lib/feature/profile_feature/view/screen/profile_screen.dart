import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_button.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_related_branch_drop_down.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      buildWhen: (previous, current) =>
          current is ProfileLoading ||
          current is ProfileManagerLoaded ||
          current is ProfileError,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
          ),
        ),
        drawer: canPop
            ? null
            : AppDrawer(
                currentPage: 'profile',
              ),
        body: state is ProfileError
            ? RetryWidget(
                onRetry: () {
                  context.read<ProfileCubit>().getMe();
                },
              )
            : state is ProfileManagerLoaded
                ? SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileImage(),
                        ProfileNameEditor(),
                        CustomTextFormField(
                          hintText: 'Phone Number',
                          title: 'Phone Number',
                          controller: context
                              .read<ProfileCubit>()
                              .phoneNumberController,
                          enabled: context.read<ProfileCubit>().isEditing,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'Job ID (optional)',
                          title: 'Job ID (optional)',
                          controller:
                              context.read<ProfileCubit>().jobIdController,
                          enabled: context.read<ProfileCubit>().isEditing,
                        ),
                        SizedBox(height: 10.h),
                        // if (isCashier)
                        // ProfileRelatedBranchDropDown(),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
        bottomNavigationBar: ProfileButton(),
      ),
    );
  }
}
