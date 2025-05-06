import 'package:supplies/core/services/network_service/api_service.dart';

abstract class AddOfferRepo {}

class AddOfferRepoImpl extends AddOfferRepo {
  final DioHelper dioHelper;

  AddOfferRepoImpl(this.dioHelper);
}
