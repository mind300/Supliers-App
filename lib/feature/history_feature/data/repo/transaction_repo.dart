import 'dart:convert';

import '../../../../core/services/network_service/api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/services/network_service/endpoints.dart';
import '../../../../core/services/network_service/error.dart';
import '../model/transaction_model.dart';

abstract class TransactionRepo {
  Future<Either<CustomException, TransactionsResponse>> getTransactions({
    String? searchQuery,
  });
  Future<Either<CustomException, String>> postTransactions({
    required Map data,
  });
}

class TransactionRepoImpl extends TransactionRepo {
  final DioHelper dioHelper;

  TransactionRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, TransactionsResponse>> getTransactions({
    String? searchQuery,
  }) async {
    try {
      Response res = await dioHelper.get(
        endPoint: "${EndPoints.transactions}searchQuery=$searchQuery",
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

  @override
  Future<Either<CustomException, String>> postTransactions({required Map data}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.transactions,
        data: data,
      );

      if (res.statusCode != 200) {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'error',
          ),
        );
      }

      return Right(res.data['message']);
    } catch (e, stackTrace) {
      print("Error posting transaction: $e");
      print("Stack trace: $stackTrace");
      return Left(CustomException(message: "Failed to post transaction"));
    }
  }
}
