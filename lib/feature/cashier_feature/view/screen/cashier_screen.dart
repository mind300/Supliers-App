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
      appBar: AppBar(
        title: const Text('Cashier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(currentPage: 'cashiers'),
      body: BlocConsumer<CashiersCubit, CashiersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CashiersError) {
            return RetryWidget(
              onRetry: () {
                context.read<CashiersCubit>().getCashiers();
              },
            );
          }
          if (state is CashiersSuccess) {
            if (state.cashiers.content!.isEmpty) {
              return Center(
                child: Text(
                  'No cashiers available',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }

            return AnimationLimiter(
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      state.cashiers.pagination?.nextPageUrl != null) {
                    context.read<CashiersCubit>().getCashiers();
                  }
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
                  itemCount: state.cashiers.content!.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: EmployeeDataBuilder(
                            id: state.cashiers.content![index].id.toString() ??
                                '',
                            name: state.cashiers.content![index].name ?? '',
                            image: state.cashiers.content![index].images ?? '',
                            userType: UsersType.cashier,
                            subtitle:
                                state.cashiers.content![index].jobId ?? '',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.addCashiers);
        },
        icon: Icons.add,
      ),
    );
  }
}
