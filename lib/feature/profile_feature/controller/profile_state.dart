part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileNameUpdated extends ProfileState {}

final class ProfileDelete extends ProfileState {}

// /profileImageUpdated
final class ProfileImageUpdated extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileManagerLoaded extends ProfileState {
  final ManagerProfileModel managerProfileModel;

  ProfileManagerLoaded(this.managerProfileModel);
}

final class ProfileMeLoaded extends ProfileState {
  final MyProfileModel managerProfileModel;

  ProfileMeLoaded(this.managerProfileModel);
}

final class ProfileCashierLoaded extends ProfileState {
  final ManagerProfileModel cashierProfileModel;

  ProfileCashierLoaded(this.cashierProfileModel);
}

final class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

final class ProfileDeleteError extends ProfileState {
  final String error;

  ProfileDeleteError(this.error);
}

final class ProfileDeleteSuccess extends ProfileState {
  final String message;

  ProfileDeleteSuccess(this.message);
}

//update loading
final class ProfileUpdateLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {
  final String message;

  ProfileUpdateSuccess(this.message);
}

final class ProfileUpdateError extends ProfileState {
  final String error;

  ProfileUpdateError(this.error);
}
