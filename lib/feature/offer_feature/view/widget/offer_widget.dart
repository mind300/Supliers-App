import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.offer});
  final Content offer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the offer details screen
        context.pushNamed(
          Routes.offerDetails,
          arguments: offer,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            CustomImageHandler(
              path: offer.images!.first,
              // color: Colors.black,
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 3,
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
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                offer.title ?? "",
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
                          offer.description ?? "",
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
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "${offer.discount}% off",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.yellow,
                            ),
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
