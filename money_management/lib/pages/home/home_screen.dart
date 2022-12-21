import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/pages/analysis/analysis_screen.dart';
import 'package:money_management/pages/calendar/calendar_screen.dart';
import 'package:money_management/pages/input_money/input_screen.dart';
import 'package:money_management/pages/setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home/screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    InputScreen(),
    AnalysisScreen(),
    CalendarScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined, color: Colors.grey),
            label: 'Input',
            activeIcon: Icon(Icons.add_outlined, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_outlined, color: Colors.grey),
            label: 'Analysis',
            activeIcon:
                Icon(Icons.equalizer_outlined, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note, color: Colors.grey),
            label: 'Calendar',
            activeIcon: Icon(Icons.event_note, color: ColorConst.primary),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            label: 'Setting',
            activeIcon: Icon(Icons.settings, color: ColorConst.primary),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConst.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
