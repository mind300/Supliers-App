import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';

class ManagerProfileScreen extends StatelessWidget {
  const ManagerProfileScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileMeLoaded || current is ProfileError || current is ProfileManagerLoaded,
      listener: (context, state) {
        if (state is ProfileDelete) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog.adaptive(
              icon: Icon(
                Icons.error,
                size: 100.sp,
                color: AppColors.red,
              ),
              content: const Text('Are you sure you want to delete this profile?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.gray),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<ProfileCubit>().deleteManager(id);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ProfileLoading) startLoading(context);
        if (state is ProfileDeleteSuccess) {
          stopLoading(context);
          Navigator.of(context).pop(true);
        }
        if (state is ProfileDeleteError) {
          stopLoading(context);
          ToastManager.showErrorToast(state.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Manager Profile'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    context.read<ProfileCubit>().deleteProfile();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                child: const Icon(
                  Icons.more_vert,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          drawer: canPop ? null : AppDrawer(currentPage: 'profile'),
          body: state is ProfileError
              ? RetryWidget(
                  onRetry: () {
                    cubit.getManagerProfile(id);
                  },
                  message: state.error,
                )
              : state is ProfileManagerLoaded
                  ? SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ProfileImage(),
                          const ProfileNameEditor(),
                          CustomTextFormField(
                            hintText: 'Phone Number',
                            title: 'Phone Number',
                            enabled: false,
                            controller: cubit.phoneNumberController,
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            hintText: 'Job ID (optional)',
                            enabled: false,
                            title: 'Job ID (optional)',
                            controller: cubit.jobIdController,
                          ),
                          SizedBox(height: 10.h),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              "Related Branches",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.managerProfileModel.content?.branch?.length ?? 0,
                            itemBuilder: (context, index) {
                              return BranchDetailsWidget(
                                branch: state.managerProfileModel.content!.branch![index],
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
