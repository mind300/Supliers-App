import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/add_offer_feature/data/repo/add_offer_repo.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit(this.addOfferRepo) : super(AddOfferInitial());
  final AddOfferRepo addOfferRepo;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages = [];
  TextEditingController offerNameController = TextEditingController();
  TextEditingController offerDescriptionController = TextEditingController();

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(limit: 5);
      if (images != null && images.isNotEmpty) {
        selectedImages = images;
        emit(AddOfferImagePicked());
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  removeImage(int index) {
    if (selectedImages != null && selectedImages!.isNotEmpty) {
      selectedImages!.removeAt(index);
      emit(AddOfferImagePicked());
    }
  }

  addOffer() async {
    if (selectedImages != null && selectedImages!.isNotEmpty) {
      emit(AddOfferLoading());
      // var res = await addOfferRepo.addOffer(
      //   offerName: offerNameController.text,
      //   offerDescription: offerDescriptionController.text,
      //   images: selectedImages!,
      // );
      // res.fold(
      //   (l) {
      //     emit(AddOfferError(l.message));
      //   },
      //   (r) {
      //     emit(AddOfferSuccess(r));
      //   },
      // );
    } else {
      emit(AddOfferError("Please select at least one image"));
    }
  }
}
