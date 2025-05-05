import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/cashier_feature/data/model/cashier_model/cashier_model.dart';
import 'package:supplies/feature/cashier_feature/data/repo/cashiers_repo.dart';

part 'cashiers_state.dart';

class CashiersCubit extends Cubit<CashiersState> {
  CashiersCubit(this.cashiersRepo) : super(CashiersInitial());
  final CashiersRepo cashiersRepo;

  void getCashiers() {
    emit(CashiersLoading());
    cashiersRepo.getCashiers().then((value) {
      value.fold(
        (l) => emit(CashiersError(l.message)),
        (r) => emit(CashiersSuccess(r)),
      );
    });
  }
}
