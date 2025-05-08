import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/manager_feature/data/model/managers_model/managers_model.dart';

abstract class ManagerRepo {
  Future<Either<CustomException, ManagersModel>> getManagers({
    required int page,
    String? search,
  });
}

class ManagerRepoImpl implements ManagerRepo {
  final DioHelper dioHelper;

  ManagerRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, ManagersModel>> getManagers({
    required int page,
    String? search,
  }) async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.manager,
        query: {
          'page': page,
          'searchQuery': search,
        },
      );
      if (res.statusCode != 200) {
        return Left(
          CustomException(
            message: res.data['message'] ?? 'Unknown error',
          ),
        );
      }
      return Right(
        ManagersModel.fromJson(res.data),
      );
    } catch (e) {
      return Left(CustomException(message: "Failed to fetch managers"));
    }
  }
}
