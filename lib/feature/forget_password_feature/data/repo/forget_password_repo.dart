import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';

abstract class ForgetPasswordRepo {
  Future<Either<CustomException, bool>> sendResetPasswordEmail({
    required String email,
  });

  Future<Either<CustomException, String>> verifyPinCode({
    required String pinCode,
    required String email,
  });

  Future<Either<CustomException, bool>> resetPassword({
    required String email,
    required String newPassword,
    required String token,
  });
}

class ForgetPasswordRepoImpl extends ForgetPasswordRepo {
  final DioHelper dioHelper;

  ForgetPasswordRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, bool>> resetPassword({required String email, required String newPassword, required String token}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.resetPassword,
        data: {
          'email': email,
          'password': newPassword,
          'password_confirmation': newPassword,
          'otp': 'otp',
          'token': token,
        },
      );
      if (res.statusCode == 200) {
        return Right(true);
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

  @override
  Future<Either<CustomException, bool>> sendResetPasswordEmail({required String email}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.forgetPassword,
        data: {
          'email': email,
          'type': "otp",
        },
      );
      if (res.statusCode == 200) {
        return Right(true);
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

  @override
  Future<Either<CustomException, String>> verifyPinCode({required String pinCode, required String email}) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.verifyPinCode,
        data: {
          'email': email,
          'otp': pinCode,
        },
      );
      if (res.statusCode == 200) {
        return Right(res.data['content'] ?? '');
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
