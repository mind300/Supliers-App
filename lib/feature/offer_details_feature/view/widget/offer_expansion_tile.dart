import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferExpansionTile extends StatelessWidget {
  const OfferExpansionTile({
    super.key,
    required this.title,
    required this.points,
  });
  final String title;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          "$points Points",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        children: [
          Text(
            '''The coupon includes:  - Park entry & Access to All games (Kids Rides  - Tubings - Zorb Ball - Snow Rocket).  - Gloves & Locker.  - Hot drink of your choice.  - Digital souvenir photo.  - Valid for all ages starting from +2 YO.
      ''',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
