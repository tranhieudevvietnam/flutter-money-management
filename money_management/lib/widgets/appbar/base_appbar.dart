import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/constants/color_constant.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const BasicAppBar(this.title, {super.key, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConst.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      // iconTheme: const IconThemeData(color: ColorConst.text),
      actions: actions,
      title: Text(title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
