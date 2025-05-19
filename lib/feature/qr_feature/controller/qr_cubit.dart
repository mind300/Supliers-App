import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/feature/add_cashier_feature/data/repo/add_cashiers_repo.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/content.dart';
import 'package:supplies/feature/history_feature/data/repo/transaction_repo.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/data/model/my_profile_model/my_profile_model.dart';
import 'package:supplies/feature/profile_feature/data/repo/profile_repo.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit(this.addCashiersRepo, this.transactionRepo) : super(QrInitial()) {
    reset();
  }
  final AddCashiersRepo addCashiersRepo;
  final TransactionRepo transactionRepo;
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountedController = TextEditingController();
  int? discountAmount;
  int? branchId = 0;
  BranchListModel? branchListModel;

  getBranchDetails() async {
    discountAmount = null;
    branchId = null;
    emit(QrLoading());
    final result = await addCashiersRepo.getBranchList();
    result.fold(
      (l) {
        emit(QrError(l.message));
      },
      (r) {
        // discountAmount = r.content?.first.discount;
        // branchId = r.content?.first.id;
        branchListModel = r;
        emit(QrLoaded(r));
      },
    );
  }

  redeem(String token) async {
    emit(QrRedeemLoading());
    final result = await transactionRepo.postTransactions(data: {
      "offer_id": branchListModel!.content!.where((e) => e.id == branchId).first.offerId,
      "amount": priceController.text,
      "token": token,
    });
    result.fold(
      (l) {
        emit(QrRedeemError(l.message));
      },
      (r) {
        // discountAmount = r.content?.first.discount;
        // branchId = r.content?.first.id;
        emit(QrRedeemLoaded(r));
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
    emit(QrDiscountedPriceUpdated());
  }

  selectedBranch(Content? b) {
    if (b == null) {
      return;
    }
    if (branchListModel!.content!.where((e) => e.id == b.id).first.offerId == null) {
      ToastManager.showToast('No active Offer for this branch');
      return;
    }
    discountAmount = b.discount;
    branchId = b.id;
    emit(QrDiscountedPriceUpdated());
  }

  @override
  Future<void> close() {
    priceController.dispose();
    priceDiscountedController.dispose();
    discountAmount = null;
    return super.close();
  }

  @override
  void onChange(Change<QrState> change) {
    super.onChange(change);
    debugPrint('QrCubit state changed: ${change.currentState} -> ${change.nextState}');
  }

  void reset() {
    priceController.clear();
    priceDiscountedController.clear();
    discountAmount = null;
    branchId = null;
    emit(QrInitial());
  }
}
