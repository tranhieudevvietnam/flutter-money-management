import 'package:flutter/material.dart';
import 'package:money_management/pages/input_money/views/input_view.dart';

class InputPayView extends StatelessWidget {
  const InputPayView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InputView(),
    );
  }
}
