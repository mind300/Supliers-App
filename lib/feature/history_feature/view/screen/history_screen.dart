import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/widgets/build_shimmer_box.dart';

import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/history_feature/view/widget/balance_widget.dart';

import '../../controller/transaction_cubit.dart';
import '../../controller/transaction_state.dart';
import '../widget/history_order_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentPage: 'History'),
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => buildShimmerBox(
                  height: 80.h,
                  width: double.infinity,
                  radius: 12.r,
                ),
              );
            } else if (state is TransactionError) {
              debugPrint(state.message);
              return Text(
                state.message,
                style: TextStyle(color: Colors.red),
              );
            } else if (state is TransactionLoaded) {
              final transactions = state.transactions;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceWidget(totalExpend: transactions.total),
                  SizedBox(height: 20.h),
                  Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: transactions.content.isEmpty
                        ? Center(
                      child: Text(
                        'No transactions available.',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: transactions.content.length,
                      itemBuilder: (context, index) => HistoryOrderWidget(
                        status: transactions.content[index].status,
                        branchName: transactions.content[index].branch?.name ?? '',
                        brandName: transactions.content[index].brand?.name ?? '',
                        cashierName: transactions.content[index].cashier?.name ?? '',
                        totalBefore: transactions.content[index].totalBeforeDiscount,
                        totalAfter: transactions.content[index].userAmount,
                        discountAmount: transactions.content[index].userDiscount,
                        createdAt: transactions.content[index].createdAt,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }


}
