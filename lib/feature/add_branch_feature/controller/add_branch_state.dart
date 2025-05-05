part of 'add_branch_cubit.dart';

@immutable
sealed class AddBranchState {}

final class AddBranchInitial extends AddBranchState {}

final class AddBranchNameUpdated extends AddBranchState {}

final class AddBranchDetailUpdated extends AddBranchState {}

final class AddBranchLoading extends AddBranchState {}

final class AddBranchSuccess extends AddBranchState {
  final String message;

  AddBranchSuccess(this.message);
}

final class AddBranchError extends AddBranchState {
  final String error;

  AddBranchError(this.error);
}
