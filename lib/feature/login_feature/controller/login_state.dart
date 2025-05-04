part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UsersType usersType;

  LoginSuccess({required this.usersType});
}

final class LoginFailure extends LoginState {
  final CustomException exception;

  LoginFailure(this.exception);
}
