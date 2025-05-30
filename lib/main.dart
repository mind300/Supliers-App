import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/di/injection.dart';
import 'package:supplies/core/routes/app_router.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/services/cache/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  initGetIt();

  runApp(
    MyApp(),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRouter().generateRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          // locale: context.locale,
          // supportedLocales: context.supportedLocales,
          // localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: AppColors.white,
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.white,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              actionsIconTheme: IconThemeData(
                color: AppColors.white,
                size: 24.sp,
              ),
            ),
          ),
          // home: App(),
        );
      },
    );
  }
}
