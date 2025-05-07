part of 'about_cubit.dart';

@immutable
sealed class AboutState {}

final class AboutInitial extends AboutState {}

final class AboutLoading extends AboutState {}

final class AboutSuccess extends AboutState {
  final String about;
  AboutSuccess(this.about);
}

final class AboutError extends AboutState {
  final String error;
  AboutError(this.error);
}
