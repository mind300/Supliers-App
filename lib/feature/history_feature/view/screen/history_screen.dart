import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/history_feature/view/screen/history_section.dart';
import 'package:supplies/feature/history_feature/view/widget/balance_details_widget.dart';
import 'package:supplies/feature/history_feature/view/widget/balance_widget.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceWidget(),
            BalanceDetailsWidget(),
            HistorySection(),
          ],
        ),
      ),
    );
  }
}
