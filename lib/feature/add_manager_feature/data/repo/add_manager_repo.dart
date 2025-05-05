import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';

abstract class AddManagerRepo {
  Future<Either<CustomException, String>> addManager({required Map data});
  Future<Either<CustomException, BranchListModel>> getAllBranches();
}

class AddManagerRepoImpl implements AddManagerRepo {
  final DioHelper dioHelper;

  AddManagerRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, String>> addManager(
      {required Map data}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.manager,
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
  Future<Either<CustomException, BranchListModel>> getAllBranches() async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.allBranchesWithoutManagers,
      );

      if (res.statusCode == 200) {
        return Right(BranchListModel.fromJson(res.data));
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
