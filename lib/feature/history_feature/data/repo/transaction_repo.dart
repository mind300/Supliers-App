
import 'dart:convert';

import '../../../../core/services/network_service/api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/services/network_service/endpoints.dart';
import '../../../../core/services/network_service/error.dart';
import '../model/transaction_model.dart';


abstract class TransactionRepo {
  Future<Either<CustomException, TransactionsResponse>> getTransactions();
}

class TransactionRepoImpl extends TransactionRepo {
  final DioHelper dioHelper;

  TransactionRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, TransactionsResponse>> getTransactions() async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.transactions,
      );

      if (res.statusCode != 200) {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'error',
          ),
        );
      }

      return Right(TransactionsResponse.fromJson(res.data));
    } catch (e, stackTrace) {
      print("Error fetching transactions: $e");
      print("Stack trace: $stackTrace");
      return Left(CustomException(message: "Failed to fetch transactions"));
    }
  }
}
