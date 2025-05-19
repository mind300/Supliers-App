import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/forget_password_feature/controller/reset_cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.token});
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => current is ResetPasswordLoading || current is ResetPasswordSuccess || current is ResetPasswordFailure,
      listener: (context, state) {
        // TODO: implement listener
        if (state is ResetPasswordLoading) {
          startLoading(context);
        } else if (state is ResetPasswordSuccess) {
          stopLoading(context);
          context.pushNamedAndRemoveAll(Routes.login);
          ToastManager.showToast(state.message);
        } else if (state is ResetPasswordFailure) {
          stopLoading(context);
          ToastManager.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Reset Password'),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 20.h,
              ),
              child: Form(
                key: context.read<ResetPasswordCubit>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageHandler(
                      width: 200.w,
                      height: 200.h,
                      path: AppImages.logoH,
                    ),
                    BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      buildWhen: (previous, current) => current is ResetPasswordVisibilityChanged,
                      builder: (context, state) {
                        return CustomTextFormField(
                          hintText: 'New Password',
                          title: "New Password",
                          controller: context.read<ResetPasswordCubit>().passwordController,
                          obscureText: true,
                          // obscureText: context.read<ResetPasswordCubit>().isPasswordVisible,
                          // suffixIcon: GestureDetector(
                          //   onTap: () {
                          //     context.read<ResetPasswordCubit>().togglePasswordVisibility();
                          //   },
                          //   child: Padding(
                          //     padding: EdgeInsets.all(12.sp),
                          //     child: CustomImageHandler(path: context.read<ResetPasswordCubit>().isPasswordVisible ? AppImages.openEye : AppImages.closeEye),
                          //   ),
                          // ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (p0.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      buildWhen: (previous, current) => current is ResetPasswordVisibilityChanged,
                      builder: (context, state) {
                        return CustomTextFormField(
                          hintText: 'Confirm Password',
                          title: "Confirm Password",
                          controller: context.read<ResetPasswordCubit>().confirmPasswordController,
                          // obscureText: context.read<ResetPasswordCubit>().isConfirmPasswordVisible,
                          obscureText: true,
                          // suffixIcon: GestureDetector(
                          //   onTap: () {
                          //     context.read<ResetPasswordCubit>().toggleConfirmPasswordVisibility();
                          //   },
                          //   child: Padding(
                          //     padding: EdgeInsets.all(12.sp),
                          //     child: CustomImageHandler(path: context.read<ResetPasswordCubit>().isConfirmPasswordVisible ? AppImages.openEye : AppImages.closeEye),
                          //   ),
                          // ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (p0.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (p0 != context.read<ResetPasswordCubit>().passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      onPressed: () {
                        context.read<ResetPasswordCubit>().resetPassword(
                              email: email,
                              token: token,
                            );
                      },
                      text: 'Reset Password',
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 24,
          //     vertical: 20,
          //   ),
          //   child:
          // ),
        );
      },
    );
  }
}
