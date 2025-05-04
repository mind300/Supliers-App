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

//edit
final class BranchDetailsError extends BranchDetailsState {
  final String error;

  BranchDetailsError(this.error);
}

final class BranchDetailsEditLoading extends BranchDetailsState {}

final class BranchDetailsEditSuccess extends BranchDetailsState {
  final String message;

  BranchDetailsEditSuccess(this.message);
}

//delete
final class BranchDetailsEditError extends BranchDetailsState {
  final String error;

  BranchDetailsEditError(this.error);
}

final class BranchDetailsDeleteLoading extends BranchDetailsState {}

final class BranchDetailsDeleteSuccess extends BranchDetailsState {
  final String message;

  BranchDetailsDeleteSuccess(this.message);
}

final class BranchDetailsDeleteError extends BranchDetailsState {
  final String error;

  BranchDetailsDeleteError(this.error);
}
