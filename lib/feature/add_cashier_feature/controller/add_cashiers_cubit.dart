import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:supplies/core/components/pagination_drop_down_menu.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/feature/add_cashier_feature/data/repo/add_cashiers_repo.dart';
import 'package:supplies/feature/add_cashier_feature/view/widget/t.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';

part 'add_cashiers_state.dart';

class AddCashiersCubit extends Cubit<AddCashiersState> {
  AddCashiersCubit(this.addCashiersRepo) : super(AddCashiersInitial());
  final AddCashiersRepo addCashiersRepo;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var branchId = 0;

  // getBranchList({
  //   int page = 1,
  // }) async {
  //   emit(AddCashiersLoading());
  //   final response = await addCashiersRepo.getBranchList(
  //     page: page,
  //   );
  //   response.fold(
  //     (l) => emit(AddCashiersError(l.message)),
  //     (r) => emit(AddCashiersSuccess(r)),
  //   );
  // }

  addCashier() async {
    if (!formKey.currentState!.validate() || branchId == 0) {
      ToastManager.showErrorToast(
        'Please fill all fields',
      );
      return;
    }
    emit(AddCashiersLoading());
    final response = await addCashiersRepo.addCashier(data: {
      'name': nameController.text,
      'email': emailController.text,
      'mobile_number': phoneController.text,
      'branch_id': branchId,
    });
    response.fold(
      (l) => emit(AddCashiersError(l.message)),
      (r) {
        emit(AddCashiersSuccess("Cashier added successfully"));
      },
    );
  }
}
