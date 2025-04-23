import 'package:get_it/get_it.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerFactory<AddBranchCubit>(() => AddBranchCubit());
  getIt.registerFactory<BranchDetailsCubit>(() => BranchDetailsCubit());
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit());
}
