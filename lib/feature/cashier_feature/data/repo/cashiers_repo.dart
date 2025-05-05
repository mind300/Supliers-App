import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/cashier_feature/data/model/cashier_model/cashier_model.dart';

abstract class CashiersRepo {
  Future<Either<CustomException, CashierModel>> getCashiers();
  // Future<Cashier> getCashierById(String id);
  // Future<void> addCashier(Cashier cashier);
  // Future<void> updateCashier(Cashier cashier);
  // Future<void> deleteCashier(String id);
}

class CashiersRepoImpl extends CashiersRepo {
  final DioHelper dioHelper;

  CashiersRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, CashierModel>> getCashiers() async {
    try {
      Response res = await dioHelper.get(endPoint: EndPoints.cashiers);
      if (res.statusCode == 200) {
        return Right(CashierModel.fromJson(res.data));
      } else {
        return Left(CustomException(
          message: res.statusMessage ?? 'Error occurred',
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }
}
