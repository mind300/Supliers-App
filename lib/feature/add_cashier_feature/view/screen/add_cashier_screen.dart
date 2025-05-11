import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_phone_input.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/feature/add_cashier_feature/controller/add_cashiers_cubit.dart';
import 'package:supplies/feature/add_cashier_feature/view/widget/t.dart';

class AddCashierScreen extends StatelessWidget {
  const AddCashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCashiersCubit, AddCashiersState>(
      listener: (context, state) {
        if (state is AddCashiersLoading) {
          startLoading(context);
        }
        if (state is AddCashiersSuccess) {
          stopLoading(context);
          ToastManager.showToast(
            'Cashier added successfully',
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Cashier'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: context.read<AddCashiersCubit>().formKey,
              child: Column(
                spacing: 10.h,
                children: [
                  CustomTextFormField(
                    title: "Cashier Name",
                    hintText: 'Cashier Name',
                    controller: context.read<AddCashiersCubit>().nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cashier name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    title: "Email",
                    hintText: 'Email',
                    controller:
                        context.read<AddCashiersCubit>().emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  CustomPhoneInput(
                    title: "Phone Number",
                    controller:
                        context.read<AddCashiersCubit>().phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                  // CustomTextFormField(
                  //   title: "Phone Number",
                  //   hintText: 'Phone Number',
                  //   controller: context.read<AddCashiersCubit>().phoneController,
                  // ),
                  // CustomTextFormField(
                  //   title: " Job ID (optional)",
                  //   hintText: ' Job ID (optional)',
                  // ),
                  PaginatedDropdownExample(
                    searchController:
                        context.read<AddCashiersCubit>().searchController,
                    onItemSelected: (p0) {
                      context.read<AddCashiersCubit>().searchController.text =
                          p0.name ?? '';
                      context.read<AddCashiersCubit>().branchId = p0.id!;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: CustomButton(
              onPressed: () {
                context.read<AddCashiersCubit>().addCashier();
              },
              text: 'Add Cashier',
            ),
          ),
        );
      },
    );
  }
}
