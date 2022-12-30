part of 'analysis_export.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ValueNotifier<int> tabCurrentIndex = ValueNotifier<int>(0);

  late AnalysisBloc bloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      tabCurrentIndex.value = _tabController.index;
    });

    bloc = BlocProvider.of<AnalysisBloc>(context);
    bloc.add(AnalysisInitEvent());
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

    return Container(
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
                    tabs: const [
                      Tab(
                        text: 'Pay',
                      ),
                      Tab(
                        text: 'Collect',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          HeaderView(
            sumCollect: 1000,
            sumPay: 22000,
          )
          // BlocBuilder<AnalysisBloc, AnalysisState>(
          //   buildWhen: (previous, current) =>
          //       current is AnalysisGetAllPaymentSuccess,
          //   builder: (context, state) {
          //     AnalysisGetAllPaymentSuccess? data;

          //     if (state is AnalysisGetAllPaymentSuccess) {
          //       data = state;
          //     }
          //     return HeaderView(
          //       sumCollect: data?.sumCollect ?? 0,
          //       sumPay: data?.sumPay ?? 0,
          //     );
          //   },
          // ),
          // BlocBuilder<AnalysisBloc, AnalysisState>(
          //   buildWhen: (previous, current) =>
          //       current is AnalysisGetAllPaymentSuccess,
          //   builder: (context, state) {
          //     AnalysisGetAllPaymentSuccess? data;

          //     if (state is AnalysisGetAllPaymentSuccess) {
          //       data = state;
          //     }
          //     return Container(
          //       margin:
          //           const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          //       padding: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           border: Border.all(color: ColorConst.border)),
          //       child: Column(children: [
          //         textTotalMethod(
          //             title: "Spending",
          //             money: data?.sumPay ?? 0,
          //             colorMoney: ColorConst.error),
          //         Divider(),
          //         textTotalMethod(
          //             title: "Income",
          //             money: data?.sumCollect ?? 0,
          //             colorMoney: ColorConst.success),
          //         Divider(),
          //         textTotalMethod(
          //             title: "Surplus",
          //             money: (data?.sumCollect ?? 0) - (data?.sumPay ?? 0),
          //             colorMoney: ColorConst.text),
          //       ]),
          //     );
          //   },
          // ),
          // Expanded(
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: const [
          //       AnalysisPayView(),
          //       AnalysisCollectView(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  textTotalMethod(
      {required String title, required num money, required Color colorMoney}) {
    return Row(
      children: [
        const Icon(
          Icons.attach_money_outlined,
        ),
        Expanded(
          child: Text(
            "$title: ",
            style: const TextStyle(fontSize: 16, color: ColorConst.text),
          ),
        ),
        Text(
          FormatUtils.instant.moneyFormat(money: money),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: colorMoney),
        ),
      ],
    );
  }
}

class AnimatedItem extends AnimatedWidget {
  final String title;
  final num money;
  const AnimatedItem(
      {super.key,
      required Animation<double> animation,
      required this.title,
      required this.money})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  static final _sizeTween = Tween<double>(begin: 0, end: 30);
  static final _heightTween = Tween<double>(begin: 0, end: 46);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return SizedBox(
      height: _heightTween.evaluate(animation),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _sizeTween.evaluate(animation),
            width: 30,
            child: Center(
              child: Icon(
                Icons.attach_money_outlined,
                size: _sizeTween.evaluate(animation),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              "title: ",
              style: TextStyle(fontSize: 16, color: ColorConst.text),
            ),
          ),
          Text(
            FormatUtils.instant.moneyFormat(money: 1000),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class HeaderView extends StatefulWidget {
  final num sumPay;
  final num sumCollect;
  const HeaderView({super.key, required this.sumPay, required this.sumCollect});

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late AnimationController controller1;
  // late AnimationController controller2;
  // late AnimationController controller3;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // controller2 = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    // controller3 = AnimationController(
    //     duration: const Duration(milliseconds: 1500), vsync: this);
    animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    // animation2 = CurvedAnimation(parent: controller2, curve: Curves.easeIn)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller2.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller2.forward();
    //     }
    //   });
    // animation3 = CurvedAnimation(parent: controller3, curve: Curves.easeIn)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller3.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller3.forward();
    //     }
    //   });
    controller1.forward();
    // controller2.forward();
    // controller3.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedItem(
          animation: animation1,
          money: widget.sumPay,
          title: "Spending: ",
        ),
        AnimatedItem(
          animation: animation1,
          money: widget.sumCollect,
          title: "Income: ",
        ),
        AnimatedItem(
          animation: animation1,
          money: widget.sumCollect - widget.sumPay,
          title: "Surplus: ",
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    // controller2.dispose();
    // controller3.dispose();
    super.dispose();
  }
}
