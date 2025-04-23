import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit() : super(AddBranchInitial());

  TextEditingController branchNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  bool isBrachDetailsExpanded = false;

  void updateBranchDetails(
    fullAddress,
  ) {
    List<String> addressParts = fullAddress.split("،");
    branchNameController.text = fullAddress;
    cityNameController.text = addressParts.last.trim();
    streetNameController.text = addressParts[1].trim();

    emit(AddBranchNameUpdated());
  }

  addBranchDetail() {
    // addBranchDetail
    isBrachDetailsExpanded = !isBrachDetailsExpanded;
    emit(AddBranchDetailUpdated());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  //onchange
  @override
  void onChange(Change<AddBranchState> change) {
    if (change.nextState is AddBranchNameUpdated) {
      // Handle the state change here
      print("Branch name updated: ${branchNameController.text}");
    }
    super.onChange(change);
  }
}
