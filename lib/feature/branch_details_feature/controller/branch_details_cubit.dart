import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/branch_details_feature/data/model/branch_details_model.dart';
import 'package:supplies/feature/branch_details_feature/data/repo/branch_details_repo.dart';

part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit(this.branchDetailsRepo) : super(BranchDetailsInitial());
  final BranchDetailsRepo branchDetailsRepo;

  TextEditingController branchNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();

  bool isEditing = false;

  toggleEditing() {
    isEditing = !isEditing;
    emit(BranchDetailsEditUpdated());
  }

  deleteBranch() {
    emit(BranchDetailsDeleteUpdated());
  }

  getBranchDetails(int branchId) async {
    emit(BranchDetailsLoading());
    var res = await branchDetailsRepo.getBranchDetails(branchId);
    res.fold((l) {
      emit(BranchDetailsError(l.message));
    }, (r) {
      branchNameController.text = r.content?.name ?? "";
      cityNameController.text = r.content?.city ?? "";
      streetNameController.text = r.content?.street ?? "";
      buildingNumberController.text = r.content?.buildingNumber ?? "";
      floorNumberController.text = r.content?.floorNumber ?? "";
      emit(BranchDetailsLoaded(r));
    });
  }
}
