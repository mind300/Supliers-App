import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/action_buttons_widget.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/delete_dialog.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/edit_button_widget.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        buildWhen: (previous, current) {
          return current is BranchDetailsLoading || current is BranchDetailsLoaded || current is BranchDetailsError;
        },
        builder: (context, state) {
          if (state is BranchDetailsError) {
            return RetryWidget(onRetry: () {
              var args = ModalRoute.of(context)!.settings.arguments as BranchDetailsArguments;
              context.read<BranchDetailsCubit>().getBranchDetails(args.branchId);
            });
          } else if (state is BranchDetailsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (CacheHelper.userType == UsersType.owner) ActionButtonsWidget(),
                  BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        hintText: 'Branch Name',
                        title: 'Branch Name',
                        controller: context.read<BranchDetailsCubit>().branchNameController,
                        enabled: context.read<BranchDetailsCubit>().isEditing,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Add detailed address",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                    buildWhen: (previous, current) {
                      return current is BranchDetailsEditUpdated;
                    },
                    builder: (context, state) {
                      return GridView(
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
                            enabled: context.read<BranchDetailsCubit>().isEditing,
                            title: "City Name",
                            controller: context.read<BranchDetailsCubit>().cityNameController,
                          ),
                          CustomTextFormField(
                            hintText: "Street Name",
                            title: "Street Name",
                            controller: context.read<BranchDetailsCubit>().streetNameController,
                            enabled: context.read<BranchDetailsCubit>().isEditing,
                          ),
                          CustomTextFormField(
                            hintText: "Building number",
                            title: "Building number",
                            controller: context.read<BranchDetailsCubit>().buildingNumberController,
                            enabled: context.read<BranchDetailsCubit>().isEditing,
                          ),
                          CustomTextFormField(
                            hintText: "Floor number",
                            title: "Floor number",
                            enabled: context.read<BranchDetailsCubit>().isEditing,
                            controller: context.read<BranchDetailsCubit>().floorNumberController,
                          ),
                        ],
                      );
                    },
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: AppColors.black,
                      ),
                      Text(
                        "Manager Details",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (state.branchDetailsModel.content?.manager == null)
                        Text("No manager assigned yet")
                      else
                        AnimationConfiguration.staggeredList(
                          position: 0,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: EmployeeDataBuilder(
                                // image: state.branchDetailsModel.content?.manager?.,
                                name: state.branchDetailsModel.content?.manager?.name,
                                id: state.branchDetailsModel.content?.manager?.id.toString(),
                                userType: UsersType.manager,
                                subtitle: state.branchDetailsModel.content?.manager?.jobId.toString(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    color: AppColors.black,
                  ),
                  Text(
                    "Cashiers Details",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (state.branchDetailsModel.content?.cashiers?.length == 0)
                    Text("No Cashiers assigned yet")
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(height: 15.h),
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: state.branchDetailsModel.content?.cashiers?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: EmployeeDataBuilder(
                                // image: AppImages.cashier,
                                name: state.branchDetailsModel.content?.cashiers?[index].name,
                                id: state.branchDetailsModel.content?.cashiers?[index].id.toString(),
                                userType: UsersType.cashier,
                                subtitle: state.branchDetailsModel.content?.cashiers?[index].jobId.toString(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

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
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: EditButtonWidget(),
      ),
    );
  }
}
