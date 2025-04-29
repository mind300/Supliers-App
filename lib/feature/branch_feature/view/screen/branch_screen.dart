import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<BranchCubit, BranchState>(
        buildWhen: (_, current) {
          return current is BranchLoading || current is BranchSuccess;
        },
        builder: (context, state) {
          if (state is BranchSuccess) {
            return AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
                itemCount: state.branches.content?.length ?? 0,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: BranchDetailsWidget(
                          branch: state.branches.content![index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BranchError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: AppImages.add,
        onPressed: () {
          context.pushNamed(Routes.addBranch);
        },
      ),
    );
  }
}
