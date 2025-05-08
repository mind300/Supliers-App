import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/transaction_repo.dart';
import 'transaction_state.dart';


class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepo repository;

  TransactionCubit(this.repository) : super(TransactionInitial());

  Future<void> getTransactions() async {
    emit(TransactionLoading());

    final result = await repository.getTransactions();

    result.fold(
          (failure) => emit(TransactionError(failure.message)),
          (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
}
