import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/branch_details_feature/data/model/branch_details_model.dart';

abstract class BranchDetailsRepo {
  Future<Either<CustomException, BranchDetailsModel>> getBranchDetails(
    int branchId,
  );
}

class BranchDetailsImpl extends BranchDetailsRepo {
  final DioHelper dioHelper;

  BranchDetailsImpl(this.dioHelper);
  @override
  Future<Either<CustomException, BranchDetailsModel>> getBranchDetails(
      int branchId) async {
    try {
      Response res =
          await dioHelper.get(endPoint: "${EndPoints.branch}/$branchId");
      if (res.statusCode == 200) {
        return Right(BranchDetailsModel.fromJson(res.data));
      } else {
        return Left(CustomException(
          message: res.data['message'] ?? "Something went wrong",
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }
}
