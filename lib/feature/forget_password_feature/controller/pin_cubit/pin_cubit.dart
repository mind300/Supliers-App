import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/forget_password_feature/controller/forget_cubit/forget_password_cubit.dart';
import 'package:supplies/feature/forget_password_feature/data/repo/forget_password_repo.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit(this.forgetPasswordCubit, this.forgetPasswordRepo) : super(PinInitial());
  final ForgetPasswordCubit forgetPasswordCubit;
  final ForgetPasswordRepo forgetPasswordRepo;
  Timer? _timer;
  TextEditingController pinController = TextEditingController();

  void startTimer() {
    int timeLeft = 60;
    _timer?.cancel(); // cancel previous timer if any

    emit(UpdateTimer(timeLeft));

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft >= 0) {
        emit(UpdateTimer(timeLeft));
      } else {
        timer.cancel();
      }
    });
  }

  checkPinCode(String pin, String email) async {
    emit(PinLoading());
    try {
      var res = await forgetPasswordRepo.verifyPinCode(
        pinCode: pin,
        email: email,
      );
      res.fold((l) {
        emit(PinFailure(l.toString()));
      }, (r) {
        emit(PinSuccess(r));
      });
    } catch (e) {
      emit(PinFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // cancel timer on cubit close
    return super.close();
  }
}
