import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/retry_widget.dart';
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddManagerLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                spacing: 10.h,
                children: [
                  CustomTextFormField(
                    title: "Manager Name",
                    hintText: 'Manager Name',
                  ),
                  CustomTextFormField(
                    title: "Email",
                    hintText: 'Email',
                  ),
                  CustomTextFormField(
                    title: "Phone Number",
                    hintText: 'Phone Number',
                  ),
                  CustomDropdown(
                    title: "Store",
                    items: state.model.content!
                        .map((e) => CustomDropdownModel(
                              id: e.id.toString(),
                              name: e.name.toString(),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  CustomTextFormField(
                    title: " Job ID (optional)",
                    hintText: ' Job ID (optional)',
                  ),
                ],
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomButton(
          onPressed: () {},
          text: 'Add Manager',
        ),
      ),
    );
  }
}
