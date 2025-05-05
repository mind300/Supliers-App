part of 'add_cashiers_cubit.dart';

@immutable
sealed class AddCashiersState {}

final class AddCashiersInitial extends AddCashiersState {}

final class AddCashiersLoading extends AddCashiersState {}

final class AddCashiersSuccess extends AddCashiersState {
  final String message;

  AddCashiersSuccess(this.message);
}

final class AddCashiersError extends AddCashiersState {
  final String message;

  AddCashiersError(this.message);
}
