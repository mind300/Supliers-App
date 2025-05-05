import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/branch_feature/data/model/branch_model.dart';
import 'package:supplies/feature/branch_feature/data/repo/branch_repo.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit(this.branchRepo) : super(BranchInitial());
  final BranchRepo branchRepo;
  BranchModel? branchModel;

  Future<void> getBranches({
    int page = 1,
    String? search,
  }) async {
    if (page == 1) {
      emit(BranchLoading());
    } else {
      emit(BranchLoadingMore());
    }
    final result = await branchRepo.getBranches(
      page: page,
      search: search,
    );
    result.fold(
      (error) => emit(BranchError(error.message)),
      (branches) {
        if (page == 1) {
          branchModel = branches;
        } else {
          branchModel!.content!.addAll(branches.content!);
          branchModel!.pagination = branches.pagination;
        }
        emit(BranchSuccess(branches));
      },
    );
  }
}
