import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/branch_feature/data/model/branch_model.dart';

abstract class BranchRepo {
  Future<Either<CustomException, BranchModel>> getBranches({
    int page,
    String? search,
  });
}

class BranchRepoImpl implements BranchRepo {
  final DioHelper dioHelper;
  BranchRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, BranchModel>> getBranches({
    int page = 1,
    String? search,
  }) async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.branch,
        query: {
          'page': page,
          'searchQuery': search,
        },
      );

      if (res.statusCode == 200) {
        return Right(BranchModel.fromJson(res.data));
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
          message: "Connection Timeout",
        ),
      );
    }
  }
}
