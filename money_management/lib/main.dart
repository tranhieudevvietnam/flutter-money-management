import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import 'package:path_provider/path_provider.dart';

import 'pages/route_export.dart';
import 'pages/setting/bloc/setting_bloc.dart';

// #docregion AppLocalizationsImport
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// #enddocregion AppLocalizationsImport

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await HiveUtil.init();

  runApp(BlocProvider(
    create: (context) => SettingBloc(),
    child: const AppConfig(),
  ));
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

    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => current is SettingChangeLanguage,
      builder: (context, state) {
        SettingChangeLanguage stateLanguage;
        if (state is SettingChangeLanguage) {
          stateLanguage = state;
        } else {
          final local = HiveUtil.boxLocal.get(HiveKeyConstant.language);
          stateLanguage = SettingChangeLanguage(Locale(local ?? "vi"));
        }
        return MaterialApp(
          initialRoute: '/',
          locale: stateLanguage.locale,
          // initialRoute: NavigationScreen.routeName,
          onGenerateRoute: generateRoute,
          supportedLocales: const [
            Locale('en'), // English
            Locale('vi'), // VietNam
            // Locale(SupportedLanguages.vietnamese, ''),
            // Locale(SupportedLanguages.english, 'US'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
