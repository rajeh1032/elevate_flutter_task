import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/routes/rotes.dart';
import 'package:movies/core/routes/routes_name.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/core/utils/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.homeScreenRoute,
          routes: Routes.myAppRoutes,
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
