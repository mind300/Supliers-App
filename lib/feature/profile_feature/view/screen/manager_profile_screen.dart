import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/enums/account_type.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_button.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_related_branch_drop_down.dart';

class ManagerProfileScreen extends StatelessWidget {
  const ManagerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return BlocConsumer<ProfileCubit, ProfileState>(
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
                content: const Text('Are you sure you want to delete this profile?'),
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
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Manager Profile',
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
          body: state is ProfileError
              ? RetryWidget(
                  onRetry: () {
                    var args = ModalRoute.of(context)!.settings.arguments;
                    cubit.getManagerProfile(
                      args is Map<String, dynamic> ? args['id'] : '',
                    );
                  },
                  message: state.error,
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
                            controller: context.read<ProfileCubit>().phoneNumberController,
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            hintText: 'Job ID (optional)',
                            title: 'Job ID (optional)',
                            controller: context.read<ProfileCubit>().jobIdController,
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Related Branches",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                )),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BranchDetailsWidget(
                                branch: state.managerProfileModel.content!.branch![index],
                              );
                            },
                            itemCount: state.managerProfileModel.content!.branch!.length,
                          ),
                          // if (isCashier)
                          // ProfileRelatedBranchDropDown(),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
          // bottomNavigationBar: ProfileButton(),
        );
      },
    );
  }
}
