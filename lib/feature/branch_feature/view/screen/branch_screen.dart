import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // final canAdd = args?['canAdd'] ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(
        currentPage: 'branch',
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
          itemCount: 10,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: BranchDetailsWidget(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: AppImages.add,
        onPressed: () {
          print('Floating Action Button Pressed');
        },
      ),
    );
  }
}
