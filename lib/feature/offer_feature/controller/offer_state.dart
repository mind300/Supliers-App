part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

final class OfferLoading extends OfferState {}

final class OfferLoaded extends OfferState {
  final OfferModel offerModel;

  OfferLoaded(this.offerModel);
}

final class OfferError extends OfferState {
  final String error;

  OfferError(this.error);
}
