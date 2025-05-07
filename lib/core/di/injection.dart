import 'package:get_it/get_it.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/network_service/api_service.dart';
import 'package:supplies/feature/about_feature/controller/about_cubit.dart';
import 'package:supplies/feature/about_feature/data/repo/about_repo.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/add_branch_feature/data/repo/add_branch_repo.dart';
import 'package:supplies/feature/add_cashier_feature/controller/add_cashiers_cubit.dart';
import 'package:supplies/feature/add_cashier_feature/data/repo/add_cashiers_repo.dart';
import 'package:supplies/feature/add_manager_feature/controller/add_manager_cubit.dart';
import 'package:supplies/feature/add_manager_feature/data/repo/add_manager_repo.dart';
import 'package:supplies/feature/add_offer_feature/controller/add_offer_cubit.dart';
import 'package:supplies/feature/add_offer_feature/data/repo/add_offer_repo.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/data/repo/branch_details_repo.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/data/repo/branch_repo.dart';
import 'package:supplies/feature/cashier_feature/controller/cashiers_cubit.dart';
import 'package:supplies/feature/cashier_feature/data/repo/cashiers_repo.dart';
import 'package:supplies/feature/login_feature/controller/login_cubit.dart';
import 'package:supplies/feature/login_feature/data/repo/login_repo.dart';
import 'package:supplies/feature/manager_feature/controller/managers_cubit.dart';
import 'package:supplies/feature/manager_feature/data/repo/manager_repo.dart';
import 'package:supplies/feature/offer_feature/controller/offer_cubit.dart';
import 'package:supplies/feature/offer_feature/data/repo/offer_repo.dart';
import 'package:supplies/feature/password_feature/controller/change_pass_cubit.dart';
import 'package:supplies/feature/password_feature/data/repo/change_pass_repoImpl.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/data/repo/profile_repo.dart';

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
  getIt.registerFactory<BranchDetailsCubit>(() => BranchDetailsCubit(getIt(), getIt()));

  //managers
  getIt.registerFactory<ManagerRepo>(() => ManagerRepoImpl(getIt()));
  getIt.registerFactory<ManagersCubit>(() => ManagersCubit(getIt()));
  //add manager
  getIt.registerFactory<AddManagerRepo>(() => AddManagerRepoImpl(getIt()));
  getIt.registerFactory<AddManagerCubit>(() => AddManagerCubit(getIt()));
  //profile
  getIt.registerFactory<ProfileRepo>(() => ProfileRepoImpl(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  //cashiers
  getIt.registerFactory<CashiersRepo>(() => CashiersRepoImpl(getIt()));
  getIt.registerFactory<CashiersCubit>(() => CashiersCubit(getIt()));
  //add cashiers
  getIt.registerFactory<AddCashiersRepo>(() => AddCashiersRepoImpl(getIt()));
  getIt.registerFactory<AddCashiersCubit>(() => AddCashiersCubit(getIt()));
  //offer
  getIt.registerFactory<OfferRepo>(() => OfferRepoImpl(getIt()));
  getIt.registerFactory<OfferCubit>(() => OfferCubit(getIt()));
  //add offer
  getIt.registerFactory<AddOfferRepo>(() => AddOfferRepoImpl(getIt()));
  getIt.registerFactory<AddOfferCubit>(() => AddOfferCubit(getIt()));
  // change password
  getIt.registerFactory<ChangePassRepoImpl>(() => ChangePassRepoImpl(getIt()));
  getIt.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(getIt()));
  //about
  getIt.registerFactory<AboutRepo>(() => AboutRepoImpl(getIt()));
  getIt.registerFactory<AboutCubit>(() => AboutCubit(getIt()));
}
