import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';

class BranchAddressInputWidget extends StatelessWidget {
  const BranchAddressInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBranchCubit, AddBranchState>(
      buildWhen: (previous, current) => current is AddBranchNameUpdated,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextFormField(
                title: "Branch Address",
                hintText: 'Branch Name',
                controller: context.read<AddBranchCubit>().branchNameController,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: () async {
                var res = await context.pushNamed(Routes.chooseAddress);
                if (res != null) {
                  print(res);
                  context.read<AddBranchCubit>().updateBranchDetails(res);
                }
              },
              child: Container(
                height: 45.sp,
                width: 45.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: AppColors.drawerLinearGradientColor,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.all(15.sp),
                child: CustomImageHandler(
                  path: AppImages.map,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
