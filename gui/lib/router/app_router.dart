import 'package:flutter/material.dart';
import 'package:gui/screen/HomeScreen/homeScreens.dart';
import 'package:gui/screen/OnboardingScreen/onBoardingScreen.dart';

abstract final class AppRouter {
  static const String root = '/';
  static const String home = '/home';
  static const String depressionTest = '/depressionTest';
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const onBoardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case depressionTest:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const onBoardingScreen());
    }
  }
}
