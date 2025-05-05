import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the offer details screen
        context.pushNamed(
          Routes.offerDetails,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            CustomImageHandler(
              path: AppImages.offerTest,
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
                color: AppColors.primaryDark,
                // borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
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
                                  color: AppColors.white,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        //price
                        Text(
                          "200 EGP",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
