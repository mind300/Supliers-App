import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/widgets/drawer.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CashierBuilder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
