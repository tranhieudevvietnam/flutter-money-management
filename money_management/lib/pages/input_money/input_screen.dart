import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/pages/input_money/input_collect/input_collect_view.dart';

import 'input_pay/input_pay_view.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 45,
              margin: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: ColorConst.primary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Pay',
                    ),
                    Tab(
                      text: 'Collect',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  // first tab bar view widget
                  Center(
                    child: InputPayView(),
                  ),

                  // second tab bar view widget
                  Center(
                    child: InputCollectView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
