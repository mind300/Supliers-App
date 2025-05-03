part of 'branch_details_cubit.dart';

@immutable
sealed class BranchDetailsState {}

final class BranchDetailsInitial extends BranchDetailsState {}

final class BranchDetailsEditUpdated extends BranchDetailsState {}

final class BranchDetailsDeleteUpdated extends BranchDetailsState {}

final class BranchDetailsLoading extends BranchDetailsState {}

final class BranchDetailsLoaded extends BranchDetailsState {
  final BranchDetailsModel branchDetailsModel;

  BranchDetailsLoaded(this.branchDetailsModel);
}

final class BranchDetailsError extends BranchDetailsState {
  final String error;

  BranchDetailsError(this.error);
}
