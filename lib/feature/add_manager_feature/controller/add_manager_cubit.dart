import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';
import 'package:supplies/feature/add_manager_feature/data/repo/add_manager_repo.dart';
import 'package:supplies/feature/add_offer_feature/view/widget/add_offer_drop_down.dart';

part 'add_manager_state.dart';

class AddManagerCubit extends Cubit<AddManagerState> {
  AddManagerCubit(this.addManagerRepo) : super(AddManagerInitial());
  final AddManagerRepo addManagerRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<DropDownModel> branchesId = [];
  var formKey = GlobalKey<FormState>();

  getBranches() async {
    emit(AddManagerLoading());
    var res = await addManagerRepo.getAllBranches();
    res.fold(
      (l) {
        emit(AddManagerError(l.message));
      },
      (r) {
        emit(AddManagerLoaded(r));
      },
    );
  }

  Future<void> addManager() async {
    // startLoading();
    emit(AddManagerAddedLoading());

    if (formKey.currentState!.validate()) {
      if (branchesId.isEmpty) {
        emit(AddManagerAddedError("Please select a branch"));
        return;
      }
      FormData data = FormData.fromMap(
        {
          "name": nameController.text,
          "mobile_number": phoneNumberController.text.toString(),
          "email": emailController.text,
          // "branches_ids[]": branchesId.map((e) => e.id).toList(),
        },
      );

      for (var element in branchesId) {
        print("branches_ids[]: ${element.id}");
        data.fields.add(
          MapEntry(
            "branch_ids[]",
            element.id.toString(),
          ),
        );
      }
      var res = await addManagerRepo.addManager(
        data: data,
      );
      res.fold(
        (l) {
          emit(AddManagerAddedError(l.message));
        },
        (r) {
          emit(AddManagerAdded(r));
        },
      );
    } else {
      emit(AddManagerAddedError("Please fill all fields"));
    }
  }

  void branchesSelected(List<DropDownModel> p0) {
    branchesId = p0;
    emit(AddManagerBranchesSelected());
  }
}
