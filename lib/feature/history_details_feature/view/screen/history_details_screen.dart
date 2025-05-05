import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/feature/offer_details_feature/view/screen/offer_details.dart';

class HistoryDetailsScreen extends StatelessWidget {
  const HistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          spacing: 10.h,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: LinearGradient(
                      colors: AppColors.linearGradientColor,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CustomImageHandler(
                    path: AppImages.plus,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.green.withOpacity(0.25),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: Text(
                          "Confirmed",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                      Text(
                        "Employee Name",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "#123456789",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                Text(
                  "17 Sep 2023\n   10:00 AM",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    title: "Total Price",
                    hintText: "Total Price",
                    enabled: false,
                    controller: TextEditingController(text: "\$500"),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomTextFormField(
                    title: "After discount",
                    hintText: "After discount",
                    enabled: false,
                    controller: TextEditingController(text: "\$100"),
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CustomImageHandler(path: AppImages.profileTest),
              title: Text(
                "Cashier Name",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "#123",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20.sp,
                color: AppColors.gray,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CustomImageHandler(path: AppImages.profileTest),
              title: Text(
                "Customer Name",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "#123",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20.sp,
                color: AppColors.gray,
              ),
            ),
            Text(
              "Order Details",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            OfferDetails(),
          ],
        ),
      ),
    );
  }
}
