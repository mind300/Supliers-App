part of 'branch_details_cubit.dart';

@immutable
sealed class BranchDetailsState {}

final class BranchDetailsInitial extends BranchDetailsState {}

final class BranchDetailsEditUpdated extends BranchDetailsState {}

final class BranchDetailsDeleteUpdated extends BranchDetailsState {}
