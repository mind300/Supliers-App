import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentPage: 'Manager'),
      appBar: AppBar(
        title: const Text('Manager'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
          itemCount: 10,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: CashierBuilder(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.addManager);
        },
        icon: Icons.add,
      ),
    );
  }
}
