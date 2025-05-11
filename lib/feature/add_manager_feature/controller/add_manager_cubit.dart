import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';
import 'package:supplies/feature/add_manager_feature/data/repo/add_manager_repo.dart';

part 'add_manager_state.dart';

class AddManagerCubit extends Cubit<AddManagerState> {
  AddManagerCubit(this.addManagerRepo) : super(AddManagerInitial());
  final AddManagerRepo addManagerRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String branchId = "";
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
      if (branchId.isEmpty) {
        emit(AddManagerAddedError("Please select a branch"));
        return;
      }
      var res = await addManagerRepo.addManager(
        data: {
          "name": nameController.text,
          "mobile_number": phoneNumberController.text.toString(),
          "email": emailController.text,
          "branch_id": branchId,
        },
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
}
