import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/cashier_feature/controller/cashiers_cubit.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/cashier_feature/controller/cashiers_cubit.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';

class CashierScreen extends StatelessWidget {
  const CashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentPage: 'cashiers'),
      appBar: AppBar(
        title: const Text('Cashier'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocConsumer<CashiersCubit, CashiersState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
        current is CashiersLoading ||
            current is CashiersSuccess ||
            current is CashiersError,
        builder: (context, state) {
          if (state is CashiersSuccess) {
            return RefreshIndicator(
              backgroundColor: AppColors.primary,
              color: AppColors.white,
              onRefresh: () async {
                context.read<CashiersCubit>().getCashiers();
              },
              child: (state.cashiers.content!.isEmpty)
                  ? Center(
                child: Text(
                  'No cashiers available',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : AnimationLimiter(
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
                        state.cashiers.pagination?.nextPageUrl != null) {
                      final cubit = context.read<CashiersCubit>();
                      cubit.getCashiers(
                        page: state.cashiers.pagination!.currentPage! + 1,
                      );
                    }
                    return false;
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w, vertical: 25.h),
                    itemCount: state.cashiers.content!.length,
                    itemBuilder: (context, index) {
                      final cashier = state.cashiers.content![index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: EmployeeDataBuilder(
                              id: cashier.id.toString(),
                              name: cashier.name ?? '',
                              image: cashier.images ?? '',
                              userType: UsersType.cashier,
                              subtitle: cashier.jobId ?? '',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (state is CashiersError) {
            return RetryWidget(
              message: state.error,
              onRetry: () {
                context.read<CashiersCubit>().getCashiers();
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          var result = await context.pushNamed(Routes.addCashiers);
          if (result == true) {
            context.read<CashiersCubit>().getCashiers();
          }
        },
        icon: Icons.add,
      ),
    );
  }
}

