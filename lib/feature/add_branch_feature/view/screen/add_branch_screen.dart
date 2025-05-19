import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/add_branch_feature/view/widget/branch_address_input_widget.dart';
import 'package:supplies/feature/add_branch_feature/view/widget/branch_detail_builder_widget.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Branch'),
      ),
      body: BlocListener<AddBranchCubit, AddBranchState>(
        listener: (context, state) {
          if (state is AddBranchLoading) {
            startLoading(context);
          }
          if (state is AddBranchSuccess) {
            stopLoading(context);
            // context.pop();
            Navigator.of(context).pop(true);
            ToastManager.showToast("Branch Added Successfully");
          }
          if (state is AddBranchError) {
            stopLoading(context);
            ToastManager.showErrorToast(
              state.error,
            );
          }
        },
        child: Form(
          key: context.read<AddBranchCubit>().formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 0),
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                hintText: "Branch Name",
                title: "Branch Name",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Branch Name is required";
                  }
                  if (p0.length < 3) {
                    return "Branch Name should be at least 3 characters";
                  }
                  return null;
                },
                controller: context.read<AddBranchCubit>().branchNameController,
              ),
              SizedBox(height: 10.h),
              BranchAddressInputWidget(),
              BranchDetailBuilderWidget(),
              Divider(height: 0, color: AppColors.black),
              SizedBox(
                height: 20.h,
              ),
              // Text(
              //   "Branch Manager Data",
              //   style: TextStyle(
              //     fontSize: 15.sp,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // SizedBox(height: 10.h),
              // Column(
              //   spacing: 10.h,
              //   children: [
              //     CustomTextFormField(
              //       hintText: "Manager Name",
              //       title: "Manager Name",
              //     ),
              //     CustomTextFormField(
              //       hintText: "E-mail",
              //       title: "E-mail",
              //     ),
              //     CustomTextFormField(
              //       hintText: "Phone Number",
              //       title: "Phone Number",
              //     ),
              //     CustomTextFormField(
              //       hintText: " Job ID (optional)",
              //       title: " Job ID (optional)",
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: CustomButton(
          onPressed: () {
            context.read<AddBranchCubit>().addBranch();
          },
          text: 'Add Branch',
        ),
      ),
    );
  }
}
