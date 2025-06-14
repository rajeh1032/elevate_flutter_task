import 'package:flutter/material.dart';
import 'package:movies/core/routes/routes_name.dart';
import 'package:movies/presentation/home_screen/ui/home_screen.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> myAppRoutes = {
    RoutesName.homeScreenRoute:(_) => HomeScreen(),
   
  
  };
}
