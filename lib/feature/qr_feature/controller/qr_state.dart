part of 'qr_cubit.dart';

@immutable
sealed class QrState {}

final class QrInitial extends QrState {}

final class QrLoading extends QrState {}

final class QrLoaded extends QrState {
  final BranchListModel qrCode;
  QrLoaded(this.qrCode);
}

final class QrError extends QrState {
  final String message;
  QrError(this.message);
}

final class QrDiscountedPriceUpdated extends QrState {}

//redeem loading.loded,error
final class QrRedeemLoading extends QrState {}

final class QrRedeemLoaded extends QrState {
  final String qrCode;
  QrRedeemLoaded(this.qrCode);
}

final class QrRedeemError extends QrState {
  final String message;
  QrRedeemError(this.message);
}
