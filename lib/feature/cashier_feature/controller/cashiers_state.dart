part of 'cashiers_cubit.dart';

@immutable
sealed class CashiersState {}

final class CashiersInitial extends CashiersState {}

final class CashiersLoading extends CashiersState {}

final class CashiersSuccess extends CashiersState {
  final CashierModel cashiers;

  CashiersSuccess(this.cashiers);
}

final class CashiersError extends CashiersState {
  final String error;

  CashiersError(this.error);
}
