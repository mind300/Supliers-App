import 'package:flutter/material.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/about_feature/view/screen/about_screen.dart';
import 'package:supplies/feature/add_branch_feature/view/screen/add_branch_screen.dart';
import 'package:supplies/feature/add_branch_feature/view/screen/choose_address_screen.dart';
import 'package:supplies/feature/branch_details_feature/view/screen/branch_details_screen.dart';
import 'package:supplies/feature/branch_feature/view/screen/branch_screen.dart';
import 'package:supplies/feature/cashier_feature/view/screen/cashier_screen.dart';
import 'package:supplies/feature/login_feature/view/screen/login_screen.dart';
import 'package:supplies/feature/offer_details_feature/view/screen/offer_details_screen.dart';
import 'package:supplies/feature/offer_feature/view/screen/offer_screen.dart';
import 'package:supplies/feature/password_feature/view/screen/password_screen.dart';
import 'package:supplies/feature/profile_feature/view/screen/profile_screen.dart';
import 'package:supplies/feature/splash_feature/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be bassed in any screen like this >> (arguments as ClassName)
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.branch:
        return MaterialPageRoute(
          builder: (_) => const BranchScreen(),
        );
      case Routes.addBranch:
        return MaterialPageRoute(
          builder: (_) => const AddBranchScreen(),
        );
      case Routes.chooseAddress:
        return MaterialPageRoute(
          builder: (_) => const GoogleMaps(),
        );
      case Routes.branchDetails:
        return MaterialPageRoute(
          builder: (_) => const BranchDetailsScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.offer:
        return MaterialPageRoute(
          builder: (_) => const OfferScreen(),
        );
      case Routes.offerDetails:
        return MaterialPageRoute(
          builder: (_) => const OfferDetailsScreen(),
        );
      case Routes.cashier:
        return MaterialPageRoute(
          builder: (_) => const CashierScreen(),
        );
      case Routes.password:
        return MaterialPageRoute(
          builder: (_) => const PasswordScreen(),
        );
      case Routes.about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route found'),
            ),
          ),
        );
    }
  }
}
