import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';
import 'package:supplies/feature/profile_feature/data/model/manager_profile_model/manager_profile_model.dart';
import 'package:supplies/feature/profile_feature/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController jobIdController = TextEditingController();
  String profileImage = "";

  toggleEditing() {
    isEditing = !isEditing;
    emit(ProfileNameUpdated());
  }

  deleteProfile() {
    emit(ProfileDelete());
  }

  getManagerProfile(
    String id,
  ) async {
    // print(id);
    emit(ProfileLoading());
    var res = await profileRepo.getManagerProfile(id);
    res.fold(
      (l) {
        emit(ProfileError(l.message));
      },
      (r) {
        nameController.text = r.content?.name ?? '';
        phoneNumberController.text = r.content?.mobilePhone ?? '';
        jobIdController.text = r.content?.jobId ?? '';
        profileImage = r.content?.images ?? '';
        emit(ProfileManagerLoaded(r));
      },
    );
  }

  getCashierProfile(
    String id,
  ) {
    print(id);
  }

  getMe() async {
    emit(ProfileLoading());
    var res = await profileRepo.getMe();
    res.fold(
      (l) {
        emit(ProfileError(l.message));
      },
      (r) {
        nameController.text = r.content?.name ?? '';
        phoneNumberController.text = r.content?.mobilePhone ?? '';
        jobIdController.text = r.content?.jobId ?? '';
        profileImage = r.content?.images ?? '';
        emit(ProfileManagerLoaded(r));
      },
    );
  }

  Future<File?> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Choose Image Source',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return null;

    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile == null) return null;
    profileImage = pickedFile.path;
    emit(ProfileImageUpdated());

    return File(pickedFile.path);
  }

  editProfile() async {
    emit(ProfileUpdateLoading());
    FormData data = FormData.fromMap({
      'name': nameController.text,
      'mobile_phone': phoneNumberController.text,
    });

    if (profileImage.isNotEmpty) {
      data.files.add(
        MapEntry(
          'media',
          await MultipartFile.fromFile(
            profileImage,
            filename: profileImage.split('/').last,
          ),
        ),
      );
    }
    var res = await profileRepo.updateProfile(
      data,
    );
    res.fold(
      (l) {
        emit(ProfileError(l.message));
      },
      (r) {
        CacheHelper.setData(CacheKeys.name, nameController.text);
        emit(ProfileUpdateSuccess("Profile updated successfully"));
      },
    );
  }
}
