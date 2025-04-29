part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileNameUpdated extends ProfileState {}

final class ProfileDelete extends ProfileState {}
