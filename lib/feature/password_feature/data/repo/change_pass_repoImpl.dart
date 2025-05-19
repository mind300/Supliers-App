import 'package:dartz/dartz.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';

abstract class ChangePassRepo {
  Future<Either<CustomException, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class ChangePassRepoImpl implements ChangePassRepo {
  final DioHelper dioHelper;

  ChangePassRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await dioHelper.post(
        endPoint: EndPoints.changePassword,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        return const Right(unit);
      } else {
        return Left(CustomException(
          message: response.data['message'] ?? 'Something went wrong',
        ));
      }
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
