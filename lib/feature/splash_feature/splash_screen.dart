import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';
import 'package:supplies/core/services/cache/cache_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (CacheHelper.getData(CacheKeys.userType) == 'owner') {
        context.pushNamedAndRemoveAll(Routes.branch);
      } else if (CacheHelper.getData(CacheKeys.userType) == 'manager') {
        context.pushNamedAndRemoveAll(Routes.cashier);
      } else if (CacheHelper.getData(CacheKeys.userType) == 'cashier') {
        context.pushNamedAndRemoveAll(Routes.offer);
      } else {
        context.pushNamedAndRemoveAll(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.logoV,
          width: 210.w,
          height: 100.h,
        ),
      ),
    );
  }
}
