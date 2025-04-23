import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/offer_feature/view/widget/offer_widget.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
      ),
      drawer: AppDrawer(currentPage: 'offers'),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 300 + index * 100),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: child,
                ),
              );
            },
            child: const OfferWidget(),
          );
        },
      ),
    );
  }
}
