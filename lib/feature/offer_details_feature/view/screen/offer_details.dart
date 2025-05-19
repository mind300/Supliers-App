import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/widgets/image_viewer.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({super.key, this.offer});
  final Content? offer;

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
            child: GestureDetector(
              onTap: () {
                // Navigate to the image viewer screen
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => ImageViewer(
                    images: offer?.images ?? [],
                  ),
                );
                Navigator.push(context, route);
                // Navigator.push(, route)
              },
              child: CustomImageHandler(
                path: offer?.images?.first,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 3,
                width: double.infinity,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
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
                          offer?.title ?? "",
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
                    offer?.description ?? "",
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "${offer?.discount}% off",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                        ),
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
        // Text(
        //   "Offer Details",
        //   style: TextStyle(
        //     fontSize: 16.sp,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // SizedBox(height: 10.h),
        // OfferExpansionTile(
        //   title: "Classic Package",
        //   points: "200",
        // ),
        // OfferExpansionTile(
        //   title: "VIP Package",
        //   points: "700",
        // ),
      ],
    );
  }
}
