import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_app_bar.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Branches',
        onChanged: (p0) {
          context.read<BranchCubit>().getBranches(search: p0);
        },
      ),
      drawer: AppDrawer(currentPage: 'branch'),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BranchCubit>().getBranches();
        },
        child: BlocConsumer<BranchCubit, BranchState>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (current is BranchLoading) {
              return true;
            }
            if (current is BranchSuccess) {
              return true;
            }
            if (current is BranchError) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is BranchSuccess) {
              final branches = context.read<BranchCubit>().branchModel?.content ?? [];

              if (branches.isEmpty) {
                return Center(
                  child: Text(
                    'No branches found',
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                );
              }

              return AnimationLimiter(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && context.read<BranchCubit>().branchModel!.pagination!.nextPageUrl != null) {
                      context.read<BranchCubit>().getBranches(
                            page: context.read<BranchCubit>().branchModel!.pagination!.currentPage! + 1,
                          );
                    }
                    return true;
                  },
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
                    itemCount: branches.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: BranchDetailsWidget(branch: branches[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            if (state is BranchError) {
              return RetryWidget(
                onRetry: () => context.read<BranchCubit>().getBranches(),
                message: state.message,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: AppImages.add,
        onPressed: () async {
          final result = await context.pushNamed(Routes.addBranch);
          if (result != null) {
            context.read<BranchCubit>().getBranches();
          }
        },
      ),
    );
  }
}
