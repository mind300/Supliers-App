import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/feature/forget_password_feature/data/repo/forget_password_repo.dart';
import 'dart:async';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());

  final ForgetPasswordRepo forgetPasswordRepo;
  TextEditingController emailController = TextEditingController();

  Future<void> sendResetPasswordEmail({
    String? email,
  }) async {
    if (emailController.text.isEmpty && email == null) {
      ToastManager.showErrorToast("Email is required");
      return;
    }
    if (!emailController.text.isValidEmail() && email == null) {
      ToastManager.showErrorToast("Email is not valid");
      return;
    }
    emit(ForgetPasswordLoading());
    var res = await forgetPasswordRepo.sendResetPasswordEmail(
      email: email ?? emailController.text,
    );
    res.fold(
      (l) {
        emit(ForgetPasswordFailure(l.message));
      },
      (r) {
        emit(ForgetPasswordSuccess());
      },
    );
  }

  @override
  void onChange(Change<ForgetPasswordState> change) {
    print('State changed from ${change.currentState} to ${change.nextState}');
    super.onChange(change);
  }
}
