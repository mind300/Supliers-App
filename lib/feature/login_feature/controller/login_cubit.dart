import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/login_feature/data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    final result = await _loginRepo.login(
      emailController.text,
      passwordController.text,
    );
    result.fold(
      (error) => emit(LoginFailure(error)),
      (success) => emit(LoginSuccess(usersType: success)),
    );
  }
}
