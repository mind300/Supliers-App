import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit() : super(BranchDetailsInitial());

  TextEditingController branchNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerPhoneController = TextEditingController();
  TextEditingController managerEmailController = TextEditingController();
  TextEditingController jobIdController = TextEditingController();
  bool isEditing = false;

  toggleEditing() {
    isEditing = !isEditing;
    emit(BranchDetailsEditUpdated());
  }

  deleteBranch() {
    emit(BranchDetailsDeleteUpdated());
  }
}
