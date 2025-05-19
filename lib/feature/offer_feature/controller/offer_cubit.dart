import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/offer_model.dart';
import 'package:supplies/feature/offer_feature/data/repo/offer_repo.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this.offerRepo) : super(OfferInitial());
  final OfferRepo offerRepo;

  getOffers({
    int page = 1,
    String? search,
  }) async {
    emit(OfferLoading());
    var res = await offerRepo.getOffers(
      page: page,
      search: search,
    );
    res.fold(
      (l) {
        emit(OfferError(l.message));
      },
      (r) {
        emit(OfferLoaded(r));
      },
    );
  }
}
