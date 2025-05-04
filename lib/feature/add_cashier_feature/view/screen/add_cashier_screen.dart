import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';

class AddCashierScreen extends StatelessWidget {
  const AddCashierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cashier'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          spacing: 10.h,
          children: [
            CustomTextFormField(
              title: "Cashier Name",
              hintText: 'Cashier Name',
            ),
            CustomTextFormField(
              title: "Email",
              hintText: 'Email',
            ),
            CustomTextFormField(
              title: "Phone Number",
              hintText: 'Phone Number',
            ),
            CustomTextFormField(
              title: " Job ID (optional)",
              hintText: ' Job ID (optional)',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomButton(
          onPressed: () {},
          text: 'Add Cashier',
        ),
      ),
    );
  }
}
