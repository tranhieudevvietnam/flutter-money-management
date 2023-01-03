part of 'input_money_export.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ValueNotifier<int> tabCurrentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      tabCurrentIndex.value = _tabController.index;
    });
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
        margin: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(
          children: [
            Container(
              // height: 45,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              decoration: const BoxDecoration(
                color: ColorConst.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ValueListenableBuilder(
                  valueListenable: tabCurrentIndex,
                  builder: (context, value, child) {
                    return TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.white,
                      ),
                      labelColor: ColorConst.primary,
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.payMoney,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.collectMoney,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Center(
                    child: BlocProvider(
                      create: (context) => InputMoneyBloc(),
                      child: const InputPayView(),
                    ),
                  ),

                  // second tab bar view widget
                  Center(
                    child: BlocProvider(
                      create: (context) => InputMoneyBloc(),
                      child: const InputCollectView(),
                    ),
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
