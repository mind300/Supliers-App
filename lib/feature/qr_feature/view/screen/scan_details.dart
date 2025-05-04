import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';

class ScanDetails extends StatelessWidget {
  const ScanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          spacing: 15.h,
          children: [
            CustomTextFormField(
              enabled: false,
              controller: TextEditingController(text: '123456'),
              title: "Invoice Number",
              hintText: 'Invoice Number',
            ),
            CustomTextFormField(
              enabled: false,
              controller: TextEditingController(text: '123456'),
              title: "Invoice Date",
              hintText: 'Invoice Date',
            ),
            CustomTextFormField(
              enabled: false,
              controller: TextEditingController(text: '123456'),
              title: "Total Price",
              hintText: 'Total Price',
            ),
            CustomTextFormField(
              enabled: false,
              controller: TextEditingController(text: '123456'),
              title: "Price after Discount",
              hintText: 'Price after Discount',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: CustomButton(
          onPressed: () {
            context.pop();
          },
          text: 'Redeem',
        ),
      ),
    );
  }
}
