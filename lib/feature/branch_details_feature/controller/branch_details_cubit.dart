import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supplies/feature/branch_details_feature/data/model/branch_details_model.dart';
import 'package:supplies/feature/branch_details_feature/data/repo/branch_details_repo.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';

part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit(this.branchDetailsRepo, this.branchCubit)
      : super(BranchDetailsInitial());
  final BranchDetailsRepo branchDetailsRepo;
  final BranchCubit branchCubit;

  TextEditingController branchNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();

  bool isEditing = false;
  int branchId = 0;
  var formKey = GlobalKey<FormState>();

  toggleEditing() {
    isEditing = !isEditing;
    emit(BranchDetailsEditUpdated());
  }

  deleteBranchDialog() {
    emit(BranchDetailsDeleteUpdated());
  }

  getBranchDetails(int? branchId) async {
    emit(BranchDetailsLoading());
    var res = await branchDetailsRepo.getBranchDetails(branchId!);
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

  updateBranchDetails() async {
    await toggleEditing();
    emit(BranchDetailsEditLoading());
    if (formKey.currentState!.validate()) {
      var res = await branchDetailsRepo.updateBranchDetails(
        branchId,
        {
          'address': branchNameController.text,
          'city': cityNameController.text,
          'street': streetNameController.text,
          'building_number': buildingNumberController.text,
          'floor_number': floorNumberController.text,
          'name': branchNameController.text,
          'manager_id': '',
        },
      );
      res.fold((l) {
        emit(BranchDetailsEditError(l.message));
      }, (r) {
        emit(BranchDetailsEditSuccess(r));
      });
    } else {
      emit(BranchDetailsEditError("Please fill all fields"));
    }

    // {
    //     'address': branchAddressController.text,
    //     'city': cityNameController.text,
    //     'street': streetNameController.text,
    //     'building_number': buildingNumberController.text,
    //     'floor_number': floorNumberController.text,
    //     'name': branchNameController.text,
    //     'manager_id': '',
    //   }
  }

  deleteBranch() async {
    emit(BranchDetailsDeleteLoading());
    Future.delayed(const Duration(seconds: 5));
    var res = await branchDetailsRepo.deleteBranch(branchId);
    res.fold((l) {
      emit(BranchDetailsDeleteError(l.message));
    }, (r) async {
      await branchCubit.getBranches();

      emit(BranchDetailsDeleteSuccess(r));
    });
  }
}
