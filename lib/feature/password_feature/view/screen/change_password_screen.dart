import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/widgets/drawer.dart';
import '../../controller/change_pass_cubit.dart';
import '../../controller/change_pass_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ToastManager.showToast('Password changed successfully');
          oldPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        } else if (state is ChangePasswordFailure) {
          ToastManager.showErrorToast(state.exception.message.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          drawer: AppDrawer(currentPage: 'Change Password'),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: oldPasswordController,
                  hintText: 'Current Password',
                  title: 'Current Password',
                  obscureText: true,
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: newPasswordController,
                  hintText: 'New Password',
                  title: 'New Password',
                  obscureText: true,
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm New Password',
                  title: 'Confirm New Password',
                  obscureText: true,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: CustomButton(
              text: 'Change Password',
              onPressed: () {
                context.read<ChangePasswordCubit>().changePassword(
                      oldPassword: oldPasswordController.text,
                      newPassword: newPasswordController.text,
                      confirmPassword: confirmPasswordController.text,
                    );
              },
            ),
          ),
        );
      },
    );
  }
}
