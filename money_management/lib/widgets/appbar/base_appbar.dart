import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/constants/color_constant.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const BasicAppBar(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: ColorConst.text),
      title: Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConst.text)),
    );
  }
}
