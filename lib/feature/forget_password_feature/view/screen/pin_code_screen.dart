import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/forget_password_feature/controller/pin_cubit/pin_cubit.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    return BlocConsumer<PinCubit, PinState>(
      buildWhen: (previous, current) => current is PinLoading || current is PinSuccess || current is PinFailure,
      listener: (context, state) {
        if (state is PinLoading) {
          startLoading(context);
        }
        if (state is PinSuccess) {
          stopLoading(context);
          context.pushReplacementNamed(
            Routes.resetPassword,
            arguments: {
              'email': email,
              'token': state.token,
            },
          );
        }
        if (state is PinFailure) {
          stopLoading(context);
          ToastManager.showErrorToast(
            state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print(state);
                  },
                  child: CustomImageHandler(
                    path: AppImages.logoH,
                    width: 200.w,
                    height: 150.h,
                  ),
                ),
                Text(
                  'We just sent a OTP to your registered email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.gray,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Pinput(
                    length: 4,
                    keyboardType: TextInputType.text,
                    controller: context.read<PinCubit>().pinController,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      context.read<PinCubit>().checkPinCode(
                            pin,
                            email,
                          );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<PinCubit, PinState>(
                  buildWhen: (previous, current) => current is UpdateTimer,
                  builder: (context, state) {
                    if (state is UpdateTimer) {
                      String formatTimer(int seconds) {
                        final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
                        final secs = (seconds % 60).toString().padLeft(2, '0');
                        return "$minutes:$secs";
                      }

                      return Column(
                        children: [
                          Text(
                            formatTimer(state.seconds),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.gray,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn\'t get a code? ',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              if (state.seconds <= 0) ...[
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<PinCubit>()
                                        .forgetPasswordCubit
                                        .sendResetPasswordEmail(
                                          email: email,
                                        )
                                        .then((v) {
                                      context.read<PinCubit>().startTimer();
                                    });
                                  },
                                  child: Text(
                                    'Resend Now',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 20.h,
            ),
            child: CustomButton(
              onPressed: () {
                // context.pushNamed(Routes.resetPassword);
                context.read<PinCubit>().checkPinCode(
                      context.read<PinCubit>().pinController.text,
                      email,
                    );
              },
              text: 'Check',
            ),
          ),
        );
      },
    );
  }
}
