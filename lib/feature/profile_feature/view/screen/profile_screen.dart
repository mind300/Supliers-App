import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text__form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_button.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_image.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_name_editor.dart';
import 'package:supplies/feature/profile_feature/view/widget/profile_related_branch_drop_down.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    // final isCashier = args?['isCashier'] ?? false;
    final canPop = Navigator.of(context).canPop();
    print(args);

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        drawer: canPop
            ? null
            : AppDrawer(
                currentPage: 'profile',
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(),
              ProfileNameEditor(),
              CustomTextFormField(
                hintText: 'Phone Number',
                title: 'Phone Number',
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: 'Job ID (optional)',
                title: 'Job ID (optional)',
              ),
              SizedBox(height: 10.h),
              // if (isCashier)
              // ProfileRelatedBranchDropDown(),
            ],
          ),
        ),
        bottomNavigationBar: ProfileButton(),
      ),
    );
  }
}
