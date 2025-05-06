import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/forget_password_feature/controller/forget_cubit/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          startLoading(context);
        }
        if (state is ForgetPasswordSuccess) {
          stopLoading(context);
          context.pushNamed(
            Routes.pinCode,
            arguments: context.read<ForgetPasswordCubit>().emailController.text,
          );
        }
        if (state is ForgetPasswordFailure) {
          stopLoading(context);
          ToastManager.showErrorToast(
            state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // title: const Text('Forget Password'),
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: Colors.black,
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 20.h,
              ),
              child: Column(
                // spacing: 15.h,

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageHandler(
                    path: AppImages.logoH,
                    width: 150.w,
                    height: 125.h,
                  ),
                  Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    hintText: 'Email',
                    controller: context.read<ForgetPasswordCubit>().emailController,
                    title: "Email",
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'We will send you a message to set or reset your new password',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.gray.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    onPressed: () {
                      // context.pushNamed(Routes.pinCode);
                      context.read<ForgetPasswordCubit>().sendResetPasswordEmail();
                    },
                    text: 'Send',
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 24.w,
          //     vertical: 20.h,
          //   ),
          //   child: CustomButton(
          //     onPressed: () {
          //       // context.pushNamed(Routes.pinCode);
          //       context.read<ForgetPasswordCubit>().sendResetPasswordEmail();
          //     },
          //     text: 'Send',
          //   ),
          // ),
        );
      },
    );
  }
}
