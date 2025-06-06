import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';

class BranchDetailBuilderWidget extends StatelessWidget {
  const BranchDetailBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBranchCubit, AddBranchState>(
      buildWhen: (previous, current) => current is AddBranchDetailUpdated,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add detailed address",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AddBranchCubit>().addBranchDetail();
                    },
                    child: Icon(Icons.add),
                  )
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: context.watch<AddBranchCubit>().isBrachDetailsExpanded ? 1.0 : 0.0,
                  child: context.watch<AddBranchCubit>().isBrachDetailsExpanded
                      ? GridView(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.3.h,
                            crossAxisSpacing: 10.w,
                          ),
                          children: [
                            CustomTextFormField(
                              hintText: "City Name",
                              title: "City Name",
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return "City Name is required";
                                }
                                if (p0.length < 3) {
                                  return "City Name should be at least 3 characters";
                                }
                                return null;
                              },
                              controller: context.read<AddBranchCubit>().cityNameController,
                            ),
                            CustomTextFormField(
                              hintText: "Street Name",
                              title: "Street Name",
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return "Street Name is required";
                                }
                                if (p0.length < 3) {
                                  return "Street Name should be at least 3 characters";
                                }
                                return null;
                              },
                              controller: context.read<AddBranchCubit>().streetNameController,
                            ),
                            CustomTextFormField(
                              hintText: "Building number",
                              title: "Building number",
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return "Building number is required";
                                }

                                return null;
                              },
                              controller: context.read<AddBranchCubit>().buildingNumberController,
                            ),
                            CustomTextFormField(
                              hintText: "Floor number",
                              title: "Floor number",
                              textInputType: TextInputType.number,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return "Floor number is required";
                                }

                                return null;
                              },
                              controller: context.read<AddBranchCubit>().floorNumberController,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
