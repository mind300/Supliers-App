import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supplies/core/components/custom_drop_down.dart';
import 'package:supplies/feature/add_branch_feature/data/repo/add_branch_repo.dart';
import 'package:supplies/feature/add_offer_feature/view/widget/add_offer_drop_down.dart';
import 'package:supplies/feature/branch_details_feature/data/model/branch_details_model.dart';
import 'package:supplies/feature/branch_details_feature/data/model/cashier.dart';
import 'package:supplies/feature/branch_details_feature/data/model/manager.dart';
import 'package:supplies/feature/branch_details_feature/data/repo/branch_details_repo.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/cashier_feature/data/model/cashier_model/cashier_model.dart';

part 'branch_details_state.dart';

class BranchDetailsCubit extends Cubit<BranchDetailsState> {
  BranchDetailsCubit(this.branchDetailsRepo, this.branchCubit, this.addBranchRepo) : super(BranchDetailsInitial());

  final BranchDetailsRepo branchDetailsRepo;
  final BranchCubit branchCubit;
  final AddBranchRepo addBranchRepo;

  final branchNameController = TextEditingController();
  final cityNameController = TextEditingController();
  final streetNameController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final floorNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  BranchDetailsModel branchDetailsModel = BranchDetailsModel();

  bool isEditing = false;
  int branchId = 0;

  List<DropDownModel> allCashiersIds = [];
  List<DropDownModel> selectedCashiersIds = [];
//manager
  List<Manager> allManagers = [];
  Manager? selectedManagerId;

  void toggleEditing() {
    isEditing = !isEditing;
    if (isEditing) getCashiers();
    if (isEditing) getManager();
    emit(BranchDetailsEditUpdated());
  }

  void deleteBranchDialog() {
    emit(BranchDetailsDeleteUpdated());
  }

  Future<void> getBranchDetails(int? id) async {
    branchId = id!;
    emit(BranchDetailsLoading());

    final res = await branchDetailsRepo.getBranchDetails(branchId);
    res.fold(
      (l) => emit(BranchDetailsError(l.message)),
      (r) {
        final content = r.content!;
        branchNameController.text = content.name ?? "";
        cityNameController.text = content.city ?? "";
        streetNameController.text = content.street ?? "";
        buildingNumberController.text = content.buildingNumber ?? "";
        floorNumberController.text = content.floorNumber ?? "";
        selectedCashiersIds = content.cashiers?.map((e) => DropDownModel(name: e.name!, id: e.id)).toList() ?? [];
        selectedManagerId = Manager(
          id: content.manager?.id,
          name: content.manager?.name,
        );
        branchDetailsModel = r;
        emit(BranchDetailsLoaded(r));
      },
    );
  }

  Future<void> updateBranchDetails() async {
    toggleEditing();
    emit(BranchDetailsEditLoading());

    if (formKey.currentState!.validate()) {
      final res = await branchDetailsRepo.updateBranchDetails(
        branchId,
        {
          'address': branchNameController.text,
          'city': cityNameController.text,
          'street': streetNameController.text,
          'building_number': buildingNumberController.text,
          'floor_number': floorNumberController.text,
          'name': branchNameController.text,
          'manager_id': selectedManagerId?.id == null ? null : selectedManagerId!.id.toString(),
          'cashier_ids': selectedCashiersIds.map((e) => e.id).toList(),
        },
      );
      res.fold(
        (l) => emit(BranchDetailsEditError(l.message)),
        (r) => emit(BranchDetailsEditSuccess(r)),
      );
    } else {
      emit(BranchDetailsEditError("Please fill all fields"));
    }
  }

  Future<void> deleteBranch() async {
    emit(BranchDetailsDeleteLoading());

    final res = await branchDetailsRepo.deleteBranch(branchId);
    res.fold(
      (l) => emit(BranchDetailsDeleteError(l.message)),
      (r) async {
        await branchCubit.getBranches();
        emit(BranchDetailsDeleteSuccess(r));
      },
    );
  }

  Future<void> getCashiers() async {
    final res = await branchDetailsRepo.getAllCashiersThatWithoutBranch();
    res.fold(
      (l) => emit(BranchDetailsError(l.message)),
      (r) {
        allCashiersIds = r.content?.map((e) => DropDownModel(name: e.name!, id: e.id)).toList() ?? [];
        emit(BranchDetailsGetCashiers(r));
      },
    );
  }

  void deleteManager() {
    selectedManagerId = null;
    emit(BranchDetailsEditUpdated());
  }

  void getManager() {
    addBranchRepo.getAllManagers().then((value) {
      value.fold(
        (l) => emit(BranchDetailsError(l.message)),
        (r) {
          allManagers = r ?? [];
          emit(BranchDetailsGetManager(r));
        }, // Replace with actual data if needed
      );
    });
  }

  void updateCashiers(List<DropDownModel> updated) {
    selectedCashiersIds = updated;
    //check if cashier is already selected
    for (var cashier in updated) {
      if (!selectedCashiersIds.any((e) => e.id == cashier.id)) {
        selectedCashiersIds.add(cashier);
      }
    }
    emit(BranchDetailsLoaded(branchDetailsModel));
  }

  void deleteCashier(int id) {
    final cashier = selectedCashiersIds.firstWhere((e) => e.id == id, orElse: () => DropDownModel());
    if (cashier.id != null) {
      selectedCashiersIds.removeWhere((e) => e.id == id);
      branchDetailsModel.content?.cashiers?.removeWhere((e) => e.id == id);
      allCashiersIds.add(cashier);
      emit(BranchDetailsLoaded(branchDetailsModel));
    }
  }

  @override
  void onChange(Change<BranchDetailsState> change) {
    print(change);
    super.onChange(change);
  }

  void updateManager(String? p0) {
    if (p0 != null) {
      selectedManagerId = allManagers.firstWhere((e) => e.id == int.parse(p0));
    } else {
      selectedManagerId = null;
    }
    emit(BranchDetailsLoaded(branchDetailsModel));
  }
}
