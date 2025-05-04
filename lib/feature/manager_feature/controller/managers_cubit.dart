import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/manager_feature/data/model/managers_model/managers_model.dart';
import 'package:supplies/feature/manager_feature/data/repo/manager_repo.dart';

part 'managers_state.dart';

class ManagersCubit extends Cubit<ManagersState> {
  ManagersCubit(this.managerRepo) : super(ManagersInitial());
  final ManagerRepo managerRepo;

  getManagers({int page = 1}) async {
    emit(ManagersLoading());
    var res = await managerRepo.getManagers(
      page: page,
    );
    res.fold(
      (l) {
        emit(ManagersError(l.message));
      },
      (r) {
        emit(ManagersLoaded(r));
      },
    );
  }
}
