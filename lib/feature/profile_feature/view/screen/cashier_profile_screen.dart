import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';

import '../../../../core/components/retry_widget.dart';
import '../../../branch_feature/view/widget/branch_details_widget.dart';
import 'package:supplies/feature/branch_feature/data/model/content.dart';

class CashierProfileScreen extends StatelessWidget {
  const CashierProfileScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return BlocConsumer<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) => current is ProfileCashierLoaded || current is ProfileError,
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
                        Navigator.of(context).pop();

                        context.read<ProfileCubit>().deleteCashier(
                              id.toString(),
                            );
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
          if (state is ProfileLoading) {
            startLoading(context);
          }
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
          debugPrint("Email Cashier: ${cubit.nameController.text}");
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Cashier Profile',
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      // PopupMenuItem(
                      //   child: Text('Edit'),
                      //   onTap: () {
                      //     context.read<ProfileCubit>().toggleEditing();
                      //   },
                      // ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        onTap: () {
                          // Handle delete action
                          context.read<ProfileCubit>().deleteProfile();
                        },
                      ),
                    ];
                  },
                  icon: Icon(Icons.more_vert, color: AppColors.white),
                ),
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
                      cubit.getCashierProfile(
                        args is Map<String, dynamic> ? args['id'] : '',
                      );
                    },
                    message: state.error,
                  )
                : state is ProfileCashierLoaded
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
                              enabled: false,
                              controller: context.read<ProfileCubit>().phoneNumberController,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              enabled: false,
                              hintText: 'Job ID (optional)',
                              title: 'Job ID (optional)',
                              controller: context.read<ProfileCubit>().jobIdController,
                            ),
                            SizedBox(height: 10.h),
                            // ProfileRelatedBranchDropDown(),
                            Align(alignment: Alignment.topLeft, child: Text("Profile Related Branch")),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BranchDetailsWidget(branch: Content.fromJson(state.cashierProfileModel.content!.branch![index].toJson()));
                              },
                              itemCount: state.cashierProfileModel.content!.branch!.length,
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        });
  }
}
