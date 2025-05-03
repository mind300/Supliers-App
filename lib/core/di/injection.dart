import 'package:get_it/get_it.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/add_branch_feature/data/repo/add_branch_repo.dart';
import 'package:supplies/feature/add_manager_feature/controller/add_manager_cubit.dart';
import 'package:supplies/feature/add_manager_feature/data/repo/add_manager_repo.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/data/repo/branch_details_repo.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/data/repo/branch_repo.dart';
import 'package:supplies/feature/login_feature/controller/login_cubit.dart';
import 'package:supplies/feature/login_feature/data/repo/login_repo.dart';
import 'package:supplies/feature/manager_feature/controller/managers_cubit.dart';
import 'package:supplies/feature/manager_feature/data/repo/manager_repo.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';

final getIt = GetIt.instance;

void initGetIt() {
  //helper
  getIt.registerFactory<DioHelper>(() => DioImpl());
  getIt.registerFactory<CacheHelper>(() => CacheHelper());
  //login
  getIt.registerFactory<LoginRepo>(() => LoginRepoImpl(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  //branch
  getIt.registerFactory<BranchRepo>(() => BranchRepoImpl(getIt()));
  getIt.registerFactory<BranchCubit>(() => BranchCubit(getIt()));
  //add branch
  getIt.registerFactory<AddBranchRepo>(() => AddBranchRepoImpl(getIt()));
  getIt.registerFactory<AddBranchCubit>(() => AddBranchCubit(getIt()));
  //branch details
  getIt.registerFactory<BranchDetailsRepo>(() => BranchDetailsImpl(getIt()));
  getIt.registerFactory<BranchDetailsCubit>(() => BranchDetailsCubit(getIt()));
  //managers
  getIt.registerFactory<ManagerRepo>(() => ManagerRepoImpl(getIt()));
  getIt.registerFactory<ManagersCubit>(() => ManagersCubit(getIt()));
  //add managers
  getIt.registerFactory<AddManagerRepo>(() => AddManagerRepoImpl(getIt()));
  getIt.registerFactory<AddManagerCubit>(() => AddManagerCubit(getIt()));

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit());
}
