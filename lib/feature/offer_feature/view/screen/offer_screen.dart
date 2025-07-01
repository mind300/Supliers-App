import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_app_bar.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/offer_feature/controller/offer_cubit.dart';
import 'package:supplies/feature/offer_feature/view/widget/offer_widget.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferCubit, OfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Offers',
            onChanged: (p0) async {
              await context.read<OfferCubit>().getOffers(search: p0);
            },
          ),
          drawer: AppDrawer(currentPage: 'offers'),
          body: state is OfferError
              ? RetryWidget(
                  onRetry: () {
                    context.read<OfferCubit>().getOffers();
                  },
                  message: state.error,
                )
              : state is OfferLoaded
                  ? RefreshIndicator(
                      child: state.offerModel.content!.isEmpty
                          ? Center(
                              child: Text(
                                'No offers available',
                                style: TextStyle(
                                    fontSize: 16.sp, color: AppColors.primary),
                              ),
                            )
                          : ListView.separated(
                              itemCount: state.offerModel.content?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 24.w),
                              itemBuilder: (context, index) {
                                return TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0, end: 1),
                                  duration:
                                      Duration(milliseconds: 300 + index * 100),
                                  builder: (context, value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: Transform.translate(
                                        offset: Offset(0, (1 - value) * 20),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: OfferWidget(
                                    offer: state.offerModel.content![index],
                                  ),
                                );
                              },
                            ),
                      onRefresh: () async {
                        await context.read<OfferCubit>().getOffers();
                      })
                  : Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
          // floatingActionButton: CacheHelper.getData(CacheKeys.userType) == 'cashier'
          //     ? SizedBox()
          //     : CustomFloatingActionButton(
          //         icon: Icons.add,
          //         onPressed: () async {
          //           // Navigate to the add offer screen
          //           var res = await context.pushNamed(Routes.addOffer);
          //           if (res != null) {
          //             context.read<OfferCubit>().getOffers();
          //           }
          //         },
          //       ),
        );
      },
    );
  }
}
