import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers.dart/custom_image_handler.dart';
import 'package:supplies/feature/offer_details_feature/view/widget/offer_expansion_tile.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CustomImageHandler(
              path: AppImages.offerTest,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageHandler(
              path: AppImages.profileTest,
              width: 30.w,
              height: 30.h,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "KFC",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 14.sp,
                            color: Colors.amber,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "An offer is a conditional proposal made by a buyer or seller to buy or sell an asset, which becomes legally binding if something for sale, or the submission of a total price for a product or service.",
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      "200 EGP",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Text()
                ],
              ),
            ),
          ],
        ),
        // SizedBox(height: 20.h),
        Text(
          "Offer Details",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        OfferExpansionTile(
          title: "Classic Package",
          points: "200",
        ),
        OfferExpansionTile(
          title: "VIP Package",
          points: "700",
        ),
      ],
    );
  }
}
