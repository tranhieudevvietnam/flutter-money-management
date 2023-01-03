import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/models/setting_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<SettingModel> listSettings = [
    SettingModel(title: "Language", iconData: Icons.language_outlined, key: 1),
    SettingModel(
        title: "Clean all data",
        iconData: Icons.cleaning_services_outlined,
        key: 2),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      margin: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Column(
        children: [
          Container(
            // height: 45,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorConst.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Setting",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              children: List.generate(
                  listSettings.length,
                  (index) => itemSettingMethod(
                      title: listSettings[index].title,
                      iconData: listSettings[index].iconData)),
            ),
          )
        ],
      ),
    );
  }

  Widget itemSettingMethod(
      {required String title, required IconData iconData}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorConst.border))),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: ColorConst.primary,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
