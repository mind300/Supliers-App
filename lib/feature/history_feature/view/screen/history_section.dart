import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/feature/history_feature/view/widget/history_order_widget.dart';

class HistorySection extends StatelessWidget {
  final String status,
      createdAt,
      branchName,
      brandName,
      cashierName,
      totalBefore,
      totalAfter,
      discountAmount;

  const HistorySection({super.key, required this.status, required this.createdAt, required this.branchName, required this.brandName, required this.cashierName, required this.totalBefore, required this.totalAfter, required this.discountAmount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orders',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: 5,
              itemBuilder: (context, index) => HistoryOrderWidget(
                status: status,
                branchName: branchName,
                brandName: brandName,
                cashierName: cashierName,
                totalBefore: totalBefore,
                totalAfter: totalAfter,
                discountAmount: discountAmount,
                createdAt: createdAt,
              ),
            ),
          )
        ],
      ),
    );
  }
}
