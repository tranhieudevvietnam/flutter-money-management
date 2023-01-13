import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/pages/analysis/bloc/analysis_bloc.dart';
import 'package:money_management/pages/calendar/bloc/calendar_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:money_management/pages/calendar/calendar_export.dart';

import '../analysis/analysis_export.dart';
import '../input_money/input_money_export.dart';
import '../setting/setting_export.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home/screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const InputScreen(),
    BlocProvider(
      create: (context) => AnalysisBloc(),
      child: const AnalysisScreen(),
    ),
    BlocProvider(
      create: (context) => CalendarBloc(),
      child: const CalendarScreen(),
    ),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primary,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_outlined, color: Colors.grey),
            label: AppLocalizations.of(context)!.input,
            activeIcon:
                const Icon(Icons.add_outlined, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.equalizer_outlined, color: Colors.grey),
            label: AppLocalizations.of(context)!.analysis,
            activeIcon:
                const Icon(Icons.equalizer_outlined, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_note, color: Colors.grey),
            label: AppLocalizations.of(context)!.calendar,
            activeIcon: const Icon(Icons.event_note, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            label: AppLocalizations.of(context)!.setting,
            activeIcon: const Icon(Icons.settings, color: ColorConst.primary),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConst.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
