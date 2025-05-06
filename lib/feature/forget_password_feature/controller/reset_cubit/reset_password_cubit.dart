import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/forget_password_feature/data/repo/forget_password_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.forgetPasswordRepo) : super(ResetPasswordInitial());
  final ForgetPasswordRepo forgetPasswordRepo;
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isConfirmPasswordVisible = false;
  var formKey = GlobalKey<FormState>();

  resetPassword({required String email, required String token}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(ResetPasswordLoading());
    try {
      var res = await forgetPasswordRepo.resetPassword(
        email: email,
        newPassword: passwordController.text,
        token: token,
      );
      res.fold((l) {
        emit(ResetPasswordFailure(l.toString()));
      }, (r) {
        emit(ResetPasswordSuccess("Password reset successfully"));
      });
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ResetPasswordVisibilityChanged(isPasswordVisible, isConfirmPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ResetPasswordVisibilityChanged(isPasswordVisible, isConfirmPasswordVisible));
  }
}
