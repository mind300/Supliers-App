part of 'branch_cubit.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}

final class BranchLoading extends BranchState {}

final class BranchSuccess extends BranchState {
  final BranchModel branches;

  BranchSuccess(this.branches);
}

final class BranchError extends BranchState {
  final String message;

  BranchError(this.message);
}

final class BranchLoadingMore extends BranchState {}
