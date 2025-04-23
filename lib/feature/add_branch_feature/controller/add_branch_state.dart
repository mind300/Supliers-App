part of 'add_branch_cubit.dart';

@immutable
sealed class AddBranchState {}

final class AddBranchInitial extends AddBranchState {}

final class AddBranchNameUpdated extends AddBranchState {}

final class AddBranchDetailUpdated extends AddBranchState {}
