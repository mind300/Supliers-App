import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';

class AddManagerScreen extends StatelessWidget {
  const AddManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Manager'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          spacing: 10.h,
          children: [
            CustomTextFormField(
              title: "Manager Name",
              hintText: 'Manager Name',
            ),
            CustomTextFormField(
              title: "Email",
              hintText: 'Email',
            ),
            CustomTextFormField(
              title: "Phone Number",
              hintText: 'Phone Number',
            ),
            CustomDropdown(
              title: "Store",
              items: [
                "Store 1",
                "Store 2",
                "Store 3",
                "Store 4",
                "Store 5",
              ],
              onChanged: (value) {},
            ),
            // CustomTextFormField(
            //   title: "Phone Number",
            //   hintText: 'Phone Number',
            // ),
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
          text: 'Add Manager',
        ),
      ),
    );
  }
}
