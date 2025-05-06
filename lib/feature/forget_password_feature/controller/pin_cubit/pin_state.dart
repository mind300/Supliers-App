part of 'pin_cubit.dart';

@immutable
sealed class PinState {}

final class PinInitial extends PinState {}

final class UpdateTimer extends PinState {
  final int seconds;

  UpdateTimer(this.seconds);
}

final class PinLoading extends PinState {}

final class PinSuccess extends PinState {
  final String token;

  PinSuccess(this.token);
}

final class PinFailure extends PinState {
  final String message;

  PinFailure(this.message);
}
