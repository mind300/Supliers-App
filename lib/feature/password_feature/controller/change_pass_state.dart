import 'package:flutter/foundation.dart';
import 'package:supplies/core/services/network_service/error.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {

}

final class ChangePasswordFailure extends ChangePasswordState {
  final CustomException exception;

  ChangePasswordFailure(this.exception);
}
