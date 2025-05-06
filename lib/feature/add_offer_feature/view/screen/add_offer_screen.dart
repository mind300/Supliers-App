import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_app_bar.dart';
import 'package:supplies/feature/add_offer_feature/controller/add_offer_cubit.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Offer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: BlocBuilder<AddOfferCubit, AddOfferState>(
                buildWhen: (_, state) => state is AddOfferImagePicked,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => context.read<AddOfferCubit>().pickMultipleImages(),
                    child: Container(
                      margin: EdgeInsets.all(16.sp),
                      width: 150.sp,
                      height: 150.sp,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50.sp,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
