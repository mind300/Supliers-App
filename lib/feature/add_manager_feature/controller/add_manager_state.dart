part of 'add_manager_cubit.dart';

@immutable
sealed class AddManagerState {}

final class AddManagerInitial extends AddManagerState {}

final class AddManagerLoading extends AddManagerState {}

final class AddManagerLoaded extends AddManagerState {
  final BranchListModel model;

  AddManagerLoaded(this.model);
}

final class AddManagerError extends AddManagerState {
  final String message;

  AddManagerError(this.message);
}
