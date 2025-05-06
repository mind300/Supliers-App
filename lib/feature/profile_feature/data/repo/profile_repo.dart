import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/profile_feature/data/model/manager_profile_model/manager_profile_model.dart';

abstract class ProfileRepo {
  Future<Either<CustomException, ManagerProfileModel>> getManagerProfile(
    String id,
  );
  Future<Either<CustomException, Unit>> getCashierProfile(
    String id,
  );
  Future<Either<CustomException, ManagerProfileModel>> getMe();
  Future<Either<CustomException, Unit>> updateProfile(FormData data);
}

class ProfileRepoImpl implements ProfileRepo {
  final DioHelper dioHelper;

  ProfileRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, ManagerProfileModel>> getManagerProfile(
      String id) async {
    try {
      Response res = await dioHelper.get(
        endPoint: "${EndPoints.manager}/$id",
      );
      if (res.statusCode == 200) {
        return Right(
          ManagerProfileModel.fromJson(res.data),
        );
      } else {
        return Left(
          CustomException(
            message: res.statusMessage ?? 'Error',
          ),
        );
      }
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, Unit>> getCashierProfile(String id) async {
    try {
      Response res = await dioHelper.get(
        endPoint: "${EndPoints.cashiers}/$id",
      );
      if (res.statusCode == 200) {
        // Handle the response data as needed
        return Right(unit);
      } else {
        return Left(
          CustomException(
            message: res.statusMessage ?? 'Error',
          ),
        );
      }
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, ManagerProfileModel>> getMe() async {
    try {
      Response res = await dioHelper.get(
        endPoint: EndPoints.me,
      );
      if (res.statusCode == 200) {
        // Handle the response data as needed
        return Right(
          ManagerProfileModel.fromJson(res.data),
        );
      } else {
        return Left(
          CustomException(
            message: res.statusMessage ?? 'Error',
          ),
        );
      }
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, Unit>> updateProfile(FormData data) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.updateProfile,
        data: data,
      );
      if (res.statusCode == 200) {
        return Right(unit);
      } else {
        return Left(
          CustomException(
            message: res.statusMessage ?? 'Error',
          ),
        );
      }
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
