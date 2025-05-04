part of 'managers_cubit.dart';

@immutable
sealed class ManagersState {}

final class ManagersInitial extends ManagersState {}

final class ManagersLoading extends ManagersState {}

final class ManagersLoaded extends ManagersState {
  final ManagersModel managers;

  ManagersLoaded(this.managers);
}

final class ManagersError extends ManagersState {
  final String message;

  ManagersError(this.message);
}
