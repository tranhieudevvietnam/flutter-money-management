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
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => CategoryBloc(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryInputBloc(),
                  ),
                ],
                child: const CategoryScreen(),
              ),
          settings: settings);
    case CategoryEditScreen.routeName:
      final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => CategoryBloc(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryInputBloc(),
                  ),
                ],
                child: CategoryEditScreen(data: map["data"]),
              ),
          settings: settings);
    case CategoryInputScreen.routeName:
      try {
        final map = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CategoryInputBloc(),
                  child: CategoryInputScreen(
                      data: map["data"],
                      edit: map["edit"] ?? false,
                      dataParent: map["dataParent"]),
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
    case AnalysisDetailScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const AnalysisDetailScreen(),
          settings: settings);
    case CategoryListIconScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const CategoryListIconScreen(),
          settings: settings);

    case LanguageScreen.routeName:
      // final map = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => const LanguageScreen(), settings: settings);
          
    default:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);
  }
}
