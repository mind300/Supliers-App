import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';

abstract class AddCashiersRepo {
  Future<Either<CustomException, BranchListModel>> getBranchList();
  Future<Either<CustomException, Unit>> addCashier({required Map data});
}

class AddCashiersRepoImpl extends AddCashiersRepo {
  final DioHelper dioHelper;

  AddCashiersRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, BranchListModel>> getBranchList() async {
    try {
      Response res = await dioHelper.get(endPoint: '${EndPoints.allBranches}');
      if (res.statusCode == 200) {
        return Right(BranchListModel.fromJson(res.data));
      } else {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'Something went wrong',
          ),
        );
      }
    } catch (e) {
      return Left(
        CustomException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<CustomException, Unit>> addCashier({required Map data}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.cashiers,
        data: data,
      );
      if (res.statusCode == 200) {
        return Right(unit);
      } else {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'Something went wrong',
          ),
        );
      }
    } catch (e) {
      return Left(
        CustomException(
          message: e.toString(),
        ),
      );
    }
  }
}
