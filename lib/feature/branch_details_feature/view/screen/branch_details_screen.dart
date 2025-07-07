import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_dialog.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/feature/add_offer_feature/view/widget/add_offer_drop_down.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/action_buttons_widget.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/delete_dialog.dart';
import 'package:supplies/feature/branch_details_feature/view/widget/edit_button_widget.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';
// keep all your imports as-is...

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key, required this.branchId});
  final int branchId;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Details'),
      ),
      body: BlocConsumer<BranchDetailsCubit, BranchDetailsState>(
        listener: (context, state) async {
          if (state is BranchDetailsDeleteLoading ||
              state is BranchDetailsEditLoading) {
            startLoading(context);
          }
          if (state is BranchDetailsDeleteError) {
            stopLoading(context);
            ToastManager.showErrorToast(state.error);
          }
          if (state is BranchDetailsDeleteSuccess) {
            stopLoading(context);
            Navigator.of(context).pop(true);
            ToastManager.showToast(state.message);
          }
          if (state is BranchDetailsEditSuccess) {
            stopLoading(context);
            Navigator.of(context).pop(true);

            ToastManager.showToast(state.message);
          }
          if (state is BranchDetailsEditError) {
            stopLoading(context);
            ToastManager.showErrorToast(state.error);
          }
        },
        buildWhen: (previous, current) {
          return current is BranchDetailsLoading ||
              current is BranchDetailsLoaded ||
              current is BranchDetailsError;
        },
        builder: (context, state) {
          if (state is BranchDetailsError) {
            return RetryWidget(onRetry: () {
              context.read<BranchDetailsCubit>().getBranchDetails(branchId);
            });
          } else if (state is BranchDetailsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
              child: Form(
                key: context.read<BranchDetailsCubit>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (CacheHelper.getData(CacheKeys.userType) == 'owner')
                      ActionButtonsWidget(
                        onDeletePressed: () {
                          final cubit = context.read<BranchDetailsCubit>();
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: cubit,
                              child: const DeleteDialog(),
                            ),
                          );
                        },
                      ),
                    BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          hintText: 'Branch Name',
                          title: 'Branch Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter branch name';
                            }
                            return null;
                          },
                          controller: context
                              .read<BranchDetailsCubit>()
                              .branchNameController,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5.h,
                            crossAxisSpacing: 10.w,
                          ),
                          children: [
                            CustomTextFormField(
                              hintText: "City Name",
                              enabled:
                                  context.read<BranchDetailsCubit>().isEditing,
                              title: "City Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city name';
                                }
                                return null;
                              },
                              controller: context
                                  .read<BranchDetailsCubit>()
                                  .cityNameController,
                            ),
                            CustomTextFormField(
                              hintText: "Street Name",
                              title: "Street Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter street name';
                                }
                                return null;
                              },
                              controller: context
                                  .read<BranchDetailsCubit>()
                                  .streetNameController,
                              enabled:
                                  context.read<BranchDetailsCubit>().isEditing,
                            ),
                            CustomTextFormField(
                              hintText: "Building number",
                              title: "Building number",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter building number';
                                }
                                return null;
                              },
                              controller: context
                                  .read<BranchDetailsCubit>()
                                  .buildingNumberController,
                              enabled:
                                  context.read<BranchDetailsCubit>().isEditing,
                            ),
                            CustomTextFormField(
                              hintText: "Floor number",
                              title: "Floor number",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter floor number';
                                }
                                return null;
                              },
                              enabled:
                                  context.read<BranchDetailsCubit>().isEditing,
                              controller: context
                                  .read<BranchDetailsCubit>()
                                  .floorNumberController,
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                      builder: (context, s) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: AppColors.black),
                            Text(
                              "Manager Details",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10.h),
                            if (state.branchDetailsModel.content?.manager ==
                                    null &&
                                !context.read<BranchDetailsCubit>().isEditing)
                              Text("No Manager assigned yet")
                            else if (context
                                        .read<BranchDetailsCubit>()
                                        .selectedManagerId
                                        ?.id ==
                                    null &&
                                context.read<BranchDetailsCubit>().isEditing)
                              CustomDropdown(
                                items: context
                                    .read<BranchDetailsCubit>()
                                    .allManagers
                                    .map((e) => CustomDropdownModel(
                                        name: e.name!, id: e.id.toString()))
                                    .toList(),
                                onChanged: (p0) {
                                  context
                                      .read<BranchDetailsCubit>()
                                      .updateManager(p0);
                                },
                                hintText: 'Select Manager',
                              )
                            else
                              BlocBuilder<BranchDetailsCubit,
                                  BranchDetailsState>(
                                buildWhen: (previous, current) =>
                                    state is BranchDetailsGetManager,
                                builder: (context, s) {
                                  return AnimationConfiguration.staggeredList(
                                    position: 0,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: EmployeeDataBuilder(
                                          image: state.branchDetailsModel
                                              .content?.manager?.image,
                                          name: state.branchDetailsModel.content
                                                  ?.manager?.name ??
                                              context
                                                  .read<BranchDetailsCubit>()
                                                  .selectedManagerId
                                                  ?.name,
                                          id: state.branchDetailsModel.content
                                                  ?.manager?.id
                                                  .toString() ??
                                              context
                                                  .read<BranchDetailsCubit>()
                                                  .selectedManagerId
                                                  ?.id
                                                  .toString(),
                                          userType: UsersType.manager,
                                          subtitle: state.branchDetailsModel
                                              .content?.manager?.jobId
                                              .toString(),
                                          onDeletePressed: !context
                                                  .read<BranchDetailsCubit>()
                                                  .isEditing
                                              ? null
                                              : () {
                                                  final cubit = context.read<
                                                      BranchDetailsCubit>();
                                                  cubit.deleteManager();

                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (_) => BlocProvider.value(
                                                  //     value: context.read<BranchDetailsCubit>(),
                                                  //     child: const DeleteDialog(),
                                                  //   ),
                                                  // );
                                                },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    Divider(color: AppColors.black),
                    Text(
                      "Cashiers Details",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                      // buildWhen: (previous, current) {
                      //   return state is BranchDetailsGetCashiers || current is BranchDetailsEditUpdated;
                      // },
                      builder: (context, s) {
                        if (context.read<BranchDetailsCubit>().isEditing) {
                          print(
                              "cashiers ids ${context.read<BranchDetailsCubit>().allCashiersIds.map((e) => e.id!.toString()).toList()}");
                          print(
                              "selected cashiers ids ${context.read<BranchDetailsCubit>().selectedCashiersIds.map((e) => e.id.toString()).toList()}");
                          return AddOfferDropDown(
                            items: context
                                .read<BranchDetailsCubit>()
                                .allCashiersIds,
                            selectedItems: context
                                .read<BranchDetailsCubit>()
                                .selectedCashiersIds,
                            onChanged: (p0) {
                              context
                                  .read<BranchDetailsCubit>()
                                  .updateCashiers(p0);
                            },
                            // hintText: 'Select Cashier',
                          );
                        }
                        // if (state.branchDetailsModel.content?.cashiers?.isEmpty ?? true)
                        else {
                          if (state.branchDetailsModel.content?.cashiers
                                  ?.isEmpty ??
                              true) {
                            return Text("No Cashiers assigned yet");
                          }
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
                      builder: (context, s) {
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15.h),
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: state.branchDetailsModel.content?.cashiers
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            final cashier = state
                                .branchDetailsModel.content!.cashiers![index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: EmployeeDataBuilder(
                                    name: cashier.name,
                                    id: cashier.id.toString(),
                                    userType: UsersType.cashier,
                                    subtitle: cashier.jobId.toString(),
                                    onDeletePressed: !context
                                            .read<BranchDetailsCubit>()
                                            .isEditing
                                        ? null
                                        : () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                value: context
                                                    .read<BranchDetailsCubit>(),
                                                child: CustomDialog(
                                                  isError: true,
                                                  title: 'Are you sure?',
                                                  content:
                                                      'Do you want to delete this cashier?',
                                                  confirmText: 'Delete',
                                                  onConfirm: () {
                                                    Navigator.of(context).pop();
                                                    final cubit = context.read<
                                                        BranchDetailsCubit>();
                                                    cubit.deleteCashier(
                                                        cashier.id!);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: const EditButtonWidget(),
      ),
    );
  }
}
