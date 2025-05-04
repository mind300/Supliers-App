import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';

abstract class AddBranchRepo {
  Future<Either<CustomException, String>> addBranch({required Map data});
  Future<Either<CustomException, String>> getAllManagers();
}

class AddBranchRepoImpl implements AddBranchRepo {
  final DioHelper dioHelper;

  AddBranchRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, String>> addBranch({required Map data}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.addBranch,
        data: data,
      );

      if (res.statusCode == 200) {
        return Right(res.data['message'] ?? 'Unknown error');
      } else {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'Unknown error',
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
  Future<Either<CustomException, String>> getAllManagers() async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.allManagers,
      );

      if (res.statusCode == 200) {
        return Right(res.data['message'] ?? 'Unknown error');
      } else {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'Unknown error',
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
