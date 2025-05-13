import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/feature/qr_feature/controller/qr_cubit.dart';

class ScanDetails extends StatelessWidget {
  const ScanDetails({super.key, this.code});
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: BlocConsumer<QrCubit, QrState>(
        buildWhen: (previous, current) => current is QrLoading || current is QrLoaded || current is QrError,
        listener: (context, state) {
          if (state is QrRedeemLoading) {
            startLoading(context);
          }
          if (state is QrRedeemLoaded) {
            stopLoading(context);
            Navigator.pop(context);
            ToastManager.showToast(
              state.qrCode,
            );
          }
          if (state is QrRedeemError) {
            stopLoading(context);
            ToastManager.showErrorToast(
              state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is QrError) {
            return RetryWidget(
              onRetry: () {
                context.read<QrCubit>().getBranchDetails();
              },
              message: state.message,
            );
          }
          if (state is QrLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                spacing: 15.h,
                children: [
                  CustomTextFormField(
                    enabled: false,
                    controller: TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString())),
                    ),
                    title: "Invoice Date",
                    hintText: 'Invoice Date',
                  ),
                  CustomDropdown(
                    // value: CustomDropdownModel(name: state.qrCode.content!.first.name!, id: state.qrCode.content!.first.id.toString()),
                    items: state.qrCode.content!
                        .map(
                          (e) => CustomDropdownModel(name: e.name.toString(), id: (e.id ?? 0).toString()),
                        )
                        .toList(),
                    onChanged: (value) {
                      var b = state.qrCode.content?.where((e) => e.id.toString() == value).first;
                      // context.read<QrCubit>().discountAmount = b?.discount;
                      // context.read<QrCubit>().branchId = b?.id;
                      context.read<QrCubit>().selectedBranch(b);
                      context.read<QrCubit>().updateDiscountedPrice();
                    },
                    title: 'Select Branch',
                  ),
                  BlocBuilder<QrCubit, QrState>(
                    buildWhen: (previous, current) => current is QrDiscountedPriceUpdated,
                    builder: (_, s) {
                      if (context.read<QrCubit>().branchId != null) {
                        return Column(
                          children: [
                            CustomTextFormField(
                              // enabled: false,
                              controller: context.read<QrCubit>().priceController,
                              // textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (p0) {
                                // var b = state.qrCode.content?.where((e) => e.id.toString() == p0).first;
                                context.read<QrCubit>().updateDiscountedPrice();
                              },

                              title: "Total Price",
                              hintText: 'Total Price',
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              enabled: false,
                              // controller: TextEditingController(text: '123456'),
                              controller: context.read<QrCubit>().priceDiscountedController,

                              title: "Price after Discount",
                              hintText: 'Price after Discount',
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: CustomButton(
          onPressed: () {
            context.read<QrCubit>().redeem(code!);
          },
          text: 'Redeem',
        ),
      ),
    );
  }
}
