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
          builder: (context) => BlocProvider(
                create: (context) => CategoryBloc(),
                child: const CategoryScreen(),
              ),
          settings: settings);
    case CategoryInputScreen.routeName:
      try {
        final map = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoryInputBloc(),
                  child: CategoryInputScreen(data: map["data"]),
                ),
            settings: settings);
      } catch (error) {
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoryInputBloc(),
                  child: const CategoryInputScreen(),
                ),
            settings: settings);
      }

      break;
    case CategoryListIconScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const CategoryListIconScreen(),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
  }
}
