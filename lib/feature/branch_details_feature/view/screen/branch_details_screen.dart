import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/action_buttons_widget.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/delete_dialog.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/edit_button_widget.dart';

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BranchDetailsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Branch Details'),
        ),
        body: BlocConsumer<BranchDetailsCubit, BranchDetailsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is BranchDetailsDeleteUpdated) {
              showDialog(
                context: context,
                builder: (_) {
                  return DeleteDialog();
                },
              );
              // context.read<BranchDetailsCubit>().toggleEditing();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActionButtonsWidget(),
                  CustomTextFormField(
                    hintText: 'Branch Name',
                    title: 'Branch Name',
                    controller:
                        context.read<BranchDetailsCubit>().branchNameController,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Add detailed address",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  GridView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5.h,
                      crossAxisSpacing: 10.w,
                    ),
                    children: [
                      CustomTextFormField(
                        hintText: "City Name",
                        title: "City Name",
                        controller: context
                            .read<BranchDetailsCubit>()
                            .cityNameController,
                      ),
                      CustomTextFormField(
                        hintText: "Street Name",
                        title: "Street Name",
                        controller: context
                            .read<BranchDetailsCubit>()
                            .streetNameController,
                      ),
                      CustomTextFormField(
                        hintText: "Building number",
                        title: "Building number",
                        controller: context
                            .read<BranchDetailsCubit>()
                            .buildingNumberController,
                      ),
                      CustomTextFormField(
                        hintText: "Floor number",
                        title: "Floor number",
                        controller: context
                            .read<BranchDetailsCubit>()
                            .floorNumberController,
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.black,
                  ),
                  Text(
                    "Branch Manager Data",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    spacing: 10.h,
                    children: [
                      CustomTextFormField(
                        hintText: "Manager Name",
                        title: "Manager Name",
                      ),
                      CustomTextFormField(
                        hintText: "E-mail",
                        title: "E-mail",
                      ),
                      CustomTextFormField(
                        hintText: "Phone Number",
                        title: "Phone Number",
                      ),
                      CustomTextFormField(
                        hintText: " Job ID (optional)",
                        title: " Job ID (optional)",
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: EditButtonWidget(),
        ),
      ),
    );
  }
}
