import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/add_cashier_feature/data/repo/add_cashiers_repo.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/data/model/my_profile_model/my_profile_model.dart';
import 'package:supplies/feature/profile_feature/data/repo/profile_repo.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit(this.addCashiersRepo) : super(QrInitial());
  final AddCashiersRepo addCashiersRepo;
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountedController = TextEditingController();
  int? discountAmount = 0;
  int? branchId = 0;

  getBranchDetails() async {
    emit(QrLoading());
    final result = await addCashiersRepo.getBranchList();
    result.fold(
      (l) {
        emit(QrError(l.message));
      },
      (r) {
        discountAmount = r.content?.first.discount;
        branchId = r.content?.first.id;
        emit(QrLoaded(r));
      },
    );
  }

  void updateDiscountedPrice() {
    final text = priceController.text;
    if (text.isEmpty) {
      priceDiscountedController.text = '0.00';
      return;
    }

    final originalPrice = double.tryParse(text);
    final discount = discountAmount ?? 0;

    if (originalPrice == null || discount == 0) {
      priceDiscountedController.text = originalPrice?.toStringAsFixed(2) ?? '0.00';
      return;
    }

    final discountedPrice = originalPrice - (originalPrice * (discount / 100));
    priceDiscountedController.text = discountedPrice.toStringAsFixed(2);
  }
}
