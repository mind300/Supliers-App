import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/offer_feature/data/model/categories_list/categories_list.dart';

abstract class AddOfferRepo {
  Future<Either<CustomException, CategoriesList>> getCategories();
  Future<Either<CustomException, String>> addOffer(FormData data);

  Future<Either<CustomException, String>> deleteOffer(int id);
}

class AddOfferRepoImpl extends AddOfferRepo {
  final DioHelper dioHelper;

  AddOfferRepoImpl(this.dioHelper);

  @override
  Future<Either<CustomException, CategoriesList>> getCategories() async {
    try {
      Response res = await dioHelper.get(endPoint: EndPoints.withoutOffers);
      if (res.statusCode == 200) {
        return Right(CategoriesList.fromJson(res.data));
      } else {
        return Left(CustomException(
          message: res.data['message'] ?? 'Something went wrong',
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<CustomException, String>> addOffer(FormData data) async {
    try {
      Response res = await dioHelper.post(
        endPoint: EndPoints.offer,
        data: data,
      );
      if (res.statusCode == 200) {
        return Right(res.data['message'] ?? 'Offer added successfully');
      } else {
        return Left(CustomException(
          message: res.data['message'] ?? 'Something went wrong',
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<CustomException, String>> deleteOffer(int id) async {
    try {
      Response res = await dioHelper.delete(
        endPoint: '${EndPoints.offer}/$id',
      );
      if (res.statusCode == 200) {
        return Right(res.data['message'] ?? 'Offer deleted successfully');
      } else {
        return Left(CustomException(
          message: res.data['message'] ?? 'Something went wrong',
        ));
      }
    } catch (e) {
      return Left(CustomException(
        message: e.toString(),
      ));
    }
  }
}
