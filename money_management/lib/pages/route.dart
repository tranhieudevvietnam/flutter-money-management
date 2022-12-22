part of 'route_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
    case CategoryScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const CategoryScreen(), settings: settings);
    case CategoryInputScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const CategoryInputScreen(),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
  }
}
