import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/about_feature/controller/about_cubit.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: AppDrawer(currentPage: 'about'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
        child: BlocConsumer<AboutCubit, AboutState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AboutSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageHandler(
                    path: AppImages.logoV,
                    height: 100.h,
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        state.about,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            }
            if (state is AboutError) {
              return RetryWidget(
                onRetry: () {
                  context.read<AboutCubit>().getAbout();
                },
                message: state.error,
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
