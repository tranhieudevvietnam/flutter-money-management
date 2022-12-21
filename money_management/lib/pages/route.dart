import 'package:flutter/material.dart';
import 'package:money_management/pages/home/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
  }
}
