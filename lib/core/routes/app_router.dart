import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/about_feature/controller/about_cubit.dart';
import 'package:supplies/feature/about_feature/view/screen/about_screen.dart';
import 'package:supplies/feature/add_branch_feature/controller/add_branch_cubit.dart';
import 'package:supplies/feature/history_feature/controller/transaction_cubit.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

import 'package:supplies/feature/add_branch_feature/view/screen/add_branch_screen.dart';
import 'package:supplies/feature/add_branch_feature/view/screen/choose_address_screen.dart';
import 'package:supplies/feature/add_cashier_feature/controller/add_cashiers_cubit.dart';
import 'package:supplies/feature/add_cashier_feature/view/screen/add_cashier_screen.dart';
import 'package:supplies/feature/add_manager_feature/controller/add_manager_cubit.dart';
import 'package:supplies/feature/add_manager_feature/view/screen/add_manager_screen.dart';
import 'package:supplies/feature/add_offer_feature/controller/add_offer_cubit.dart';
import 'package:supplies/feature/add_offer_feature/view/screen/add_offer_screen.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';
import 'package:supplies/feature/branch_details_feature/view/screen/branch_details_screen.dart';
import 'package:supplies/feature/branch_feature/controller/branch_cubit.dart';
import 'package:supplies/feature/branch_feature/view/screen/branch_screen.dart';
import 'package:supplies/feature/branch_feature/view/widget/branch_details_widget.dart';
import 'package:supplies/feature/cashier_feature/controller/cashiers_cubit.dart';
import 'package:supplies/feature/cashier_feature/view/screen/cashier_screen.dart';
import 'package:supplies/feature/forget_password_feature/controller/forget_cubit/forget_password_cubit.dart';
import 'package:supplies/feature/forget_password_feature/controller/pin_cubit/pin_cubit.dart';
import 'package:supplies/feature/forget_password_feature/controller/reset_cubit/reset_password_cubit.dart';
import 'package:supplies/feature/history_details_feature/view/screen/history_details_screen.dart';
import 'package:supplies/feature/history_feature/view/screen/history_screen.dart';
import 'package:supplies/feature/login_feature/controller/login_cubit.dart';
import 'package:supplies/feature/login_feature/view/screen/login_screen.dart';
import 'package:supplies/feature/manager_feature/controller/managers_cubit.dart';
import 'package:supplies/feature/manager_feature/view/screen/manager_screen.dart';
import 'package:supplies/feature/offer_details_feature/view/screen/offer_details_screen.dart';
import 'package:supplies/feature/offer_feature/controller/offer_cubit.dart';
import 'package:supplies/feature/offer_feature/view/screen/offer_screen.dart';
import 'package:supplies/feature/password_feature/controller/change_pass_cubit.dart';
import 'package:supplies/feature/password_feature/view/screen/change_password_screen.dart';
import 'package:supplies/feature/profile_feature/controller/profile_cubit.dart';
import 'package:supplies/feature/profile_feature/view/screen/cashier_profile_screen.dart';
import 'package:supplies/feature/profile_feature/view/screen/manager_profile_screen.dart';
import 'package:supplies/feature/profile_feature/view/screen/profile_screen.dart';
import 'package:supplies/feature/qr_feature/controller/qr_cubit.dart';
import 'package:supplies/feature/splash_feature/splash_screen.dart';
import 'package:supplies/feature/qr_feature/view/screen/qr_screen.dart';
import 'package:supplies/feature/qr_feature/view/screen/scan_details.dart';
import 'package:supplies/feature/forget_password_feature/view/screen/forget_password_screen.dart';
import 'package:supplies/feature/forget_password_feature/view/screen/pin_code_screen.dart';
import 'package:supplies/feature/forget_password_feature/view/screen/reset_password_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be bassed in any screen like this >> (arguments as ClassName)
    final args = settings.arguments ?? {};
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(getIt()),
            child: const LoginScreen(),
          ),
        );
      case Routes.branch:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BranchCubit>()..getBranches(),
            child: const BranchScreen(),
          ),
        );
      case Routes.addBranch:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AddBranchCubit>(),
            child: const AddBranchScreen(),
          ),
        );
      case Routes.chooseAddress:
        return MaterialPageRoute(
          builder: (_) => const GoogleMaps(),
        );
      case Routes.branchDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BranchDetailsCubit>()..getBranchDetails((args).branchId),
            child: BranchDetailsScreen(branchId: (args as BranchDetailsArguments).branchId),
          ),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getMe(),
            child: ProfileScreen(),
          ),
        );
      case Routes.managerProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getManagerProfile((args)['id'].toString()),
            child: ManagerProfileScreen(id: (args as Map)['id'].toString()),
          ),
        );
      case Routes.cashierProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getCashierProfile((args)['id'].toString()),
            child: CashierProfileScreen(id: (args as Map)['id'].toString()),
          ),
        );
      case Routes.offer:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OfferCubit>()..getOffers(),
            child: const OfferScreen(),
          ),
        );
      case Routes.addOffer:
        return MaterialPageRoute(
          builder: (_) {
            if (args is Content) {
              return BlocProvider(
                create: (context) => getIt<AddOfferCubit>()
                  // ..getCategores()
                  ..initData(args),
                child: AddOfferScreen(),
              );
            }
            return BlocProvider(
              create: (context) => getIt<AddOfferCubit>()..getCategores(),
              child: const AddOfferScreen(),
            );
          },
        );
      case Routes.offerDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AddOfferCubit>(),
            child: OfferDetailsScreen(offer: args as Content),
          ),
        );
      case Routes.cashier:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CashiersCubit>()..getCashiers(),
            child: const CashierScreen(),
          ),
        );
      case Routes.about:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AboutCubit>()..getAbout(),
            child: const AboutScreen(),
          ),
        );
      case Routes.history:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<TransactionCubit>()..getTransactions(),
            child: const HistoryScreen(),
          ),
        );
      case Routes.historyDetails:
        return MaterialPageRoute(
          builder: (_) => const HistoryDetailsScreen(),
        );
      case Routes.qr:
        return MaterialPageRoute(
          builder: (_) => QrScreen(),
        );
      case Routes.addCashiers:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AddCashiersCubit>()..getBranchList(),
            child: const AddCashierScreen(),
          ),
        );
      case Routes.scanDetails:
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments;
            return BlocProvider(
              create: (context) => getIt<QrCubit>(),
              child: ScanDetails(code: args.toString()),
            );
          },
        );
      case Routes.manager:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ManagersCubit>()..getManagers(),
            child: const ManagerScreen(),
          ),
        );
      case Routes.addManager:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AddManagerCubit>()..getBranches(),
            child: const AddManagerScreen(),
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.pinCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PinCubit>()..startTimer(),
            child: PinCodeScreen(
              email: args.toString(),
            ),
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) {
            Map argsMap = args as Map;
            return BlocProvider(
              create: (context) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordScreen(
                email: argsMap['email'],
                token: argsMap['token'],
              ),
            );
          },
        );

      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ChangePasswordCubit>(),
            child: ChangePasswordScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('No Route Found'),
            ),
            body: Center(
              child: Text('No route found'),
            ),
          ),
        );
    }
  }
}
