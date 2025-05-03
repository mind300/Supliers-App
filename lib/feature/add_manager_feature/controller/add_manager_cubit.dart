import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/add_manager_feature/data/model/branch_list_model/branch_list_model.dart';
import 'package:supplies/feature/add_manager_feature/data/repo/add_manager_repo.dart';

part 'add_manager_state.dart';

class AddManagerCubit extends Cubit<AddManagerState> {
  AddManagerCubit(this.addManagerRepo) : super(AddManagerInitial());
  final AddManagerRepo addManagerRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
}
