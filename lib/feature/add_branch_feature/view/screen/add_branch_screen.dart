import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/add_branch_feature/view/widget/branch_address_input_widget.dart';
import 'package:supplies/feature/add_branch_feature/view/widget/branch_detail_builder_widget.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Branch'),
      ),
      body: BlocProvider(
        create: (context) => getIt<AddBranchCubit>(),
        child: ListView(
          padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 0),
          children: [
            // CustomImageHandler(
            //   path: AppImages.logoH,
            //   width: 200.w,
            //   height: 150.h,
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     text: 'Please add your',
            //     style: TextStyle(
            //       fontSize: 32.sp,
            //       fontWeight: FontWeight.w400,
            //       color: Color(0xFF285199),
            //     ),
            //     children: [
            //       TextSpan(
            //         text: '\nBranch',
            //         style: TextStyle(
            //           fontSize: 38.sp,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20.h,
            ),
            BranchAddressInputWidget(),
            BranchDetailBuilderWidget(),
            Divider(height: 0, color: AppColors.black),
            SizedBox(
              height: 20.h,
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: CustomButton(
          onPressed: () {},
          text: 'Add Branch',
        ),
      ),
    );
  }
}
