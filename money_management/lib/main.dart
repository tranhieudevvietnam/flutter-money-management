import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/route_export.dart';

void main() {
  runApp(const AppConfig());
}

class AppConfig extends StatefulWidget {
  final String? token;
  final String? userId;
  const AppConfig({Key? key, this.token, this.userId}) : super(key: key);

  @override
  State<AppConfig> createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  late BuildContext contextAppConfig;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contextAppConfig = context;

    return const MaterialApp(
      initialRoute: '/',

      // initialRoute: NavigationScreen.routeName,
      onGenerateRoute: generateRoute,
      supportedLocales: [
        Locale('en'), // English
        Locale('vi'), // VietNam
        // Locale(SupportedLanguages.vietnamese, ''),
        // Locale(SupportedLanguages.english, 'US'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
