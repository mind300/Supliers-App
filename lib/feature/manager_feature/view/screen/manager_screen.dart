import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supplies/core/components/custom_app_bar.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/cashier_feature/view/widget/cashier_builder.dart';
import 'package:supplies/feature/manager_feature/controller/managers_cubit.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (p0) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      drawer: AppDrawer(currentPage: 'Managers'),
      appBar: CustomAppBar(
        title: "Manager",
        onChanged: (p0) {
          context.read<ManagersCubit>().getManagers(search: p0);
        },
      ),
      body: BlocConsumer<ManagersCubit, ManagersState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          return current is ManagersLoading || current is ManagersLoaded || current is ManagersError;
        },
        builder: (context, state) {
          if (state is ManagersLoaded) {
            return RefreshIndicator(
              backgroundColor: AppColors.primary,
              color: AppColors.white,
              onRefresh: () async {
                context.read<ManagersCubit>().getManagers();
              },
              child: (state.managers.content!.isEmpty)
                  ? Center(
                      child: Text(
                        'No data',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16.sp,
                        ),
                      ),
                    )
                  : AnimationLimiter(
                      child: NotificationListener(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification && notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
                            final cubit = context.read<ManagersCubit>();
                            if (state.managers.pagination?.nextPageUrl != null) {
                              cubit.getManagers(
                                page: state.managers.pagination!.currentPage! + 1,
                              );
                            }
                          }
                          return false;
                        },
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 15.h),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
                          itemCount: state.managers.content?.length ?? 0,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: EmployeeDataBuilder(
                                    name: state.managers.content![index].name ?? '',
                                    image: state.managers.content![index].images,
                                    subtitle: state.managers.content![index].jobId ?? '',
                                    id: state.managers.content![index].id.toString(),
                                    userType: UsersType.manager,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            );
          } else if (state is ManagersError) {
            return RetryWidget(
              message: state.message,
              onRetry: () async {
                context.read<ManagersCubit>().getManagers();
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
          var res = await context.pushNamed(Routes.addManager);
          if (res == true) {
            context.read<ManagersCubit>().getManagers();
          }
        },
        icon: Icons.add,
      ),
    );
  }
}
