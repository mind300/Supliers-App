import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/core/services/network_service/endpoints.dart';
import 'package:supplies/core/services/network_service/error.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/offer_model.dart';

abstract class OfferRepo {
  Future<Either<CustomException, OfferModel>> getOffers(
      {required int page, String? search});
}

class OfferRepoImpl extends OfferRepo {
  final DioHelper dioHelper;

  OfferRepoImpl(this.dioHelper);
  @override
  Future<Either<CustomException, OfferModel>> getOffers(
      {required int page, String? search}) async {
    try {
      Response res = await dioHelper.get(endPoint: EndPoints.offer, query: {
        "searchQuery": search,
      });
      if (res.statusCode == 200) {
        return Right(OfferModel.fromJson(res.data));
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
