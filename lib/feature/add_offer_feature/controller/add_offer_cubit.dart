import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supplies/feature/add_offer_feature/data/repo/add_offer_repo.dart';
import 'package:supplies/feature/add_offer_feature/view/widget/add_offer_drop_down.dart';
import 'package:supplies/feature/offer_feature/data/model/categories_list/categories_list.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit(this.addOfferRepo) : super(AddOfferInitial());
  final AddOfferRepo addOfferRepo;
  final ImagePicker _picker = ImagePicker();
  List? selectedImages = [];
  TextEditingController offerNameController = TextEditingController();
  TextEditingController offerDiscountController = TextEditingController();
  TextEditingController offerDescriptionController = TextEditingController();
  List<DropDownModel> selectedCategories = [];
  var formKey = GlobalKey<FormState>();
  bool isEdit = false;

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(limit: 5);
      if (images.isNotEmpty) {
        selectedImages = images.map((e) => File(e.path)).toList();
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
    if (!formKey.currentState!.validate()) {
      emit(AddOfferError("Please fill all fields"));
      return;
    }
    if (selectedImages!.isEmpty) {
      emit(AddOfferError("Please select images"));
      return;
    }
    // if (offerNameController.text.isEmpty) {
    //   emit(AddOfferError("Please enter offer name"));
    //   return;
    // }
    // if (offerDiscountController.text.isEmpty) {
    //   emit(AddOfferError("Please enter offer discount"));
    //   return;
    // }
    // if (offerDescriptionController.text.isEmpty) {
    //   emit(AddOfferError("Please enter offer description"));
    //   return;
    // }
    if (selectedCategories.isEmpty) {
      emit(AddOfferError("Please select categories"));
      return;
    }

    FormData formData = FormData.fromMap({
      'title': offerNameController.text,
      'discount': int.parse(offerDiscountController.text),
      'description': offerDescriptionController.text,
    });
    for (var element in selectedCategories) {
      formData.fields.add(MapEntry("branch_ids[]", element.id.toString()));
    }
    selectedImages!.forEach((element) async {
      formData.files.add(MapEntry(
        "media[]",
        await MultipartFile.fromFile(element.path, filename: element.name),
      ));
    });

    emit(AddOfferLoading());
    var res = await addOfferRepo.addOffer(formData);
    res.fold(
      (l) {
        emit(AddOfferError(l.message));
      },
      (r) {
        emit(AddOfferSuccess(r));
      },
    );
  }

  getCategores() async {
    isEdit = false;
    emit(AddOfferCategoriesLoading());
    var res = await addOfferRepo.getCategories();
    res.fold(
      (l) {
        emit(AddOfferCategoryError(l.message));
      },
      (r) {
        emit(AddOfferCategoriesLoaded(r));
      },
    );
  }

  void onCategoryChanged(List<DropDownModel> selectedItems) {
    selectedCategories = selectedItems;
    emit(AddOfferCategoryChanged());
  }

  initData(Content args) {
    isEdit = true;
    offerNameController.text = args.categoryName ?? "";
    offerDiscountController.text = args.discount.toString();
    offerDescriptionController.text = args.description ?? "";
    selectedImages = args.images?.map((e) => XFile(e)).toList();
    getCategores();

    // selectedCategories = args.categories!
    //     .map((e) => DropDownModel(id: e.id, name: e.name))
    // .toList();
  }

  void deleteOffer(int id) async {
    emit(AddOfferDeleteLoading());
    var res = await addOfferRepo.deleteOffer(id);
    res.fold(
      (l) {
        emit(AddOfferDeleteError(l.message));
      },
      (r) {
        emit(AddOfferDeleteSuccess(r));
      },
    );
  }

  @override
  void onChange(Change<AddOfferState> change) {
    print("State changed from ${change.currentState} to ${change.nextState}");
    super.onChange(change);
  }
}
