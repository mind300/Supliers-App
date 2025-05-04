import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/branch_feature/data/model/branch_model.dart';
import 'package:supplies/feature/branch_feature/data/repo/branch_repo.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit(this.branchRepo) : super(BranchInitial());
  final BranchRepo branchRepo;

  Future<void> getBranches() async {
    emit(BranchLoading());
    final result = await branchRepo.getBranches();
    result.fold(
      (error) => emit(BranchError(error.message)),
      (branches) => emit(BranchSuccess(branches)),
    );
  }
}
