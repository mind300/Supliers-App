import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';

class BalanceDetailsWidget extends StatelessWidget {
  const BalanceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        // color: Colors.white,
        gradient: const LinearGradient(
          colors: AppColors.drawerLinearGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          _buildDetailsRow(
            title: "Total Due",
            amount: "\$50,000",
            isUp: true,
          ),
          Container(
            width: 1.w,
            height: 50.h,
            color: AppColors.dividerColor,
          ),
          _buildDetailsRow(
            title: "Total Saving",
            amount: "\$50,000",
            isUp: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsRow({
    required String title,
    required String amount,
    required bool isUp,
  }) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            color: isUp ? AppColors.green : AppColors.red,
            size: 35.sp,
          ),
          SizedBox(width: 8.w),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
