import 'package:flutter/material.dart';
import 'package:todo_app/screens/splash/splash.dart';
import 'package:todo_app/screens/tab_box/tab_box.dart';

abstract class RouteName {
  static const splash = '/splash';
  static const tabBox = '/tabBox';
  static const home = '/home';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteName.tabBox:
        return MaterialPageRoute(builder: (_) => const TabBox());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
