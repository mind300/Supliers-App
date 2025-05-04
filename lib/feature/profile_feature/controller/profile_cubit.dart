import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    nameController.text = CacheHelper.getData(CacheKeys.name) ?? "Unknown";

    // phoneNumber.text = CacheHelper.getData(CacheKeys.) ?? "Unknown";
  }

  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  toggleEditing() {
    isEditing = !isEditing;
    emit(ProfileNameUpdated());
  }

  deleteProfile() {
    emit(ProfileDelete());
  }
}
