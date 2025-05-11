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
