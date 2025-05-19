import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:supplies/feature/add_branch_feature/data/repo/add_branch_repo.dart';

part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit(this.addBranchRepo) : super(AddBranchInitial());
  final AddBranchRepo addBranchRepo;

  TextEditingController branchNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  bool isBrachDetailsExpanded = true;
  var formKey = GlobalKey<FormState>();

  void updateBranchDetails(
    fullAddress,
  ) {
    List<String> addressParts = fullAddress.split("،");
    branchAddressController.text = fullAddress;
    cityNameController.text = addressParts.last.trim();
    streetNameController.text = addressParts[1].trim();

    emit(AddBranchNameUpdated());
  }

  addBranchDetail() {
    // addBranchDetail
    isBrachDetailsExpanded = !isBrachDetailsExpanded;
    emit(AddBranchDetailUpdated());
  }

  addBranch() async {
    emit(AddBranchLoading());
    if (formKey.currentState!.validate()) {
      var res = await addBranchRepo.addBranch(data: {
        'address': branchAddressController.text,
        'city': cityNameController.text,
        'street': streetNameController.text,
        'building_number': buildingNumberController.text,
        'floor_number': floorNumberController.text,
        'name': branchNameController.text,
        'manager_id': '',
      });
      res.fold(
        (l) {
          emit(AddBranchError(l.message));
        },
        (r) {
          emit(AddBranchSuccess(r));
        },
      );
    } else {
      emit(AddBranchError("Please fill all fields"));
      return;
    }
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
