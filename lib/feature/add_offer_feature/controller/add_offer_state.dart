part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

final class AddOfferInitial extends AddOfferState {}

final class AddOfferImagePicked extends AddOfferState {}

final class AddOfferLoading extends AddOfferState {}

final class AddOfferSuccess extends AddOfferState {
  final String message;

  AddOfferSuccess(this.message);
}

final class AddOfferError extends AddOfferState {
  final String message;

  AddOfferError(this.message);
}
