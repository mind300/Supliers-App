import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplies/core/enums/users_type.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/login_feature/data/model/login_model.dart';

abstract class LoginRepo {
  Future<Either<CustomException, UsersType>> login(
    String email,
    String password,
  );
}

class LoginRepoImpl implements LoginRepo {
  final DioHelper dioHelper;

  LoginRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, UsersType>> login(
      String email, String password) async {
    try {
      Response res = await dioHelper.post(
        headers: {"Device-Token": "121321321"},
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        var model = LoginModel.fromJson(res.data);
        CacheHelper.setData(CacheKeys.name, model.name);
        CacheHelper.setData(CacheKeys.token, model.token);
        CacheHelper.setData(CacheKeys.id, model.userId);
        CacheHelper.setData(CacheKeys.image, "");
        CacheHelper.setData(CacheKeys.userType, model.role.toString());
        return Right(model.role == 'owner'
            ? UsersType.owner
            : model.role == 'cashier'
                ? UsersType.cashier
                : UsersType.manager);
      } else {
        return Left(
          CustomException(message: res.data['message']),
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
