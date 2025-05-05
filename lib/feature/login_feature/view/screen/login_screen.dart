import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/login_feature/controller/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            startLoading(context);
          }
          if (state is LoginSuccess) {
            stopLoading(context);
            if (state.usersType == UsersType.owner) {
              context.pushNamedAndRemoveAll(Routes.branch);
            } else if (state.usersType == UsersType.manager) {
              context.pushNamedAndRemoveAll(Routes.cashier);
            } else if (state.usersType == UsersType.cashier) {
              context.pushNamedAndRemoveAll(Routes.offer);
            }
            ToastManager.showToast("Login Successfully");
          }
          if (state is LoginFailure) {
            stopLoading(context);
            ToastManager.showErrorToast(
              state.exception.message,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(26.sp),
          child: Form(
            key: context.read<LoginCubit>().formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 35.h),
                  CustomImageHandler(
                    path: AppImages.logoH,
                    width: 200.w,
                    height: 150.h,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.authTitleColor,
                    ),
                  ),
                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //     text: 'Please enter your email and password to ',
                  //     style: TextStyle(
                  //       fontSize: 20.sp,
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.authSubTitleColor,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: 'log in',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w800,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    title: "Email",
                    hintText: "Enter your email address",
                    controller: context.read<LoginCubit>().emailController,
                    textInputType: TextInputType.emailAddress,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Please enter your email address";
                      }
                      if (!p0.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    title: "Password",
                    hintText: "Enter your password",
                    controller: context.read<LoginCubit>().passwordController,
                    obscureText: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: CustomImageHandler(path: AppImages.closeEye),
                    ),
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Please enter your password";
                      }

                      if (p0.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "Forget password?",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    onPressed: () {
                      context.read<LoginCubit>().login();
                      // context.pushNamedAndRemoveAll(
                      //   Routes.branch,
                      //   // arguments: {
                      //   //   "canAdd": true,
                      //   // },
                      // );
                    },
                    text: "Log in",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
