import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/core/components/custom_phone_input.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/feature/add_manager_feature/controller/add_manager_cubit.dart';

class AddManagerScreen extends StatelessWidget {
  const AddManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Manager'),
      ),
      body: BlocConsumer<AddManagerCubit, AddManagerState>(
        listener: (context, state) {
          print(state);
          if (state is AddManagerAddedLoading) {
            startLoading(context);
          }
          if (state is AddManagerAdded) {
            stopLoading(context);
            Navigator.of(context).pop(true);
            // context.pop();
            ToastManager.showToast(state.message);
          }
          if (state is AddManagerAddedError) {
            stopLoading(context);
            ToastManager.showErrorToast(
              state.message,
            );
          }
        },
        buildWhen: (previous, current) {
          return current is AddManagerLoading ||
              current is AddManagerLoaded ||
              current is AddManagerError;
        },
        builder: (context, state) {
          if (state is AddManagerLoaded) {
            if (state.model.content == null || state.model.content!.isEmpty) {
              return RetryWidget(
                onRetry: () {
                  context.pop();
                },
                message: "Please add a branch first",
                buttonText: "Back",
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: context.read<AddManagerCubit>().formKey,
                child: Column(
                  spacing: 10.h,
                  children: [
                    CustomTextFormField(
                      title: "Manager Name",
                      hintText: 'Manager Name',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter manager name";
                        }
                        if (p0.length < 3) {
                          return "Manager name must be at least 3 characters";
                        }
                        return null;
                      },
                      controller:
                          context.read<AddManagerCubit>().nameController,
                    ),
                    CustomTextFormField(
                      title: "Email",
                      hintText: 'Email',
                      validator: (p0) {
                        if (p0 != null && p0.isEmpty) {
                          return "Please enter email";
                        }
                        if (!p0.isValidEmail()) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      controller:
                          context.read<AddManagerCubit>().emailController,
                    ),
                    CustomPhoneInput(
                      controller:
                          context.read<AddManagerCubit>().phoneNumberController,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Please enter phone number";
                        }

                        return null;
                      },
                      title: "Phone Number",
                    ),
                    CustomDropdown(
                      title: "Store",
                      items: state.model.content!
                          .map((e) => CustomDropdownModel(
                                id: e.id.toString(),
                                name: e.name.toString(),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context.read<AddManagerCubit>().branchId =
                            value.toString();
                      },
                    ),
                    // CustomTextFormField(
                    //   title: " Job ID (optional)",
                    //   hintText: ' Job ID (optional)',
                    // ),
                  ],
                ),
              ),
            );
          }
          if (state is AddManagerError) {
            return RetryWidget(
              message: state.message,
              onRetry: () {
                context.read<AddManagerCubit>().getBranches();
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<AddManagerCubit, AddManagerState>(
        buildWhen: (previous, current) =>
            current is AddManagerAddedError ||
            current is AddManagerError ||
            current is AddManagerLoaded,
        builder: (context, state) {
          if (state is AddManagerAddedError || state is AddManagerError) {
            return const SizedBox();
          }
          if (state is AddManagerLoaded && state.model.content!.isEmpty) {
            return const SizedBox();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: CustomButton(
              onPressed: () {
                context.read<AddManagerCubit>().addManager();
              },
              text: 'Add Manager',
            ),
          );
        },
      ),
    );
  }
}
