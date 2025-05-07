import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';

abstract class AboutRepo {
  Future<Either<CustomException, String>> getAbout();
}

class AboutRepoImpl implements AboutRepo {
  final DioHelper dioHelper;

  AboutRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, String>> getAbout() async {
    try {
      Response res = await dioHelper.get(endPoint: EndPoints.about);
      if (res.statusCode == 200) {
        return Right(res.data['content']['content']);
      } else {
        return Left(CustomException(
          message: res.data['message'],
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }
}
