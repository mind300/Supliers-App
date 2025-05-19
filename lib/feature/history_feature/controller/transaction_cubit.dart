import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/transaction_repo.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepo repository;

  TransactionCubit(this.repository) : super(TransactionInitial());

  Future<void> getTransactions({
    String? searchQuery,
  }) async {
    emit(TransactionLoading());

    final result = await repository.getTransactions(
      searchQuery: searchQuery,
    );

    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
}
