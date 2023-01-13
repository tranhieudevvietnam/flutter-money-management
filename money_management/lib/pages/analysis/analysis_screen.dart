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

  // late AnalysisBloc bloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      tabCurrentIndex.value = _tabController.index;
    });

    // bloc = BlocProvider.of<AnalysisBloc>(context);
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
            padding: const EdgeInsets.only(
              top: 5,
            ),
            decoration: const BoxDecoration(
              color: ColorConst.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
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
                  padding: const EdgeInsets.all(5),
                  labelColor: ColorConst.primary,
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      height: 40,
                      text: AppLocalizations.of(context)!.spending,
                    ),
                    Tab(
                      height: 40,
                      text: AppLocalizations.of(context)!.income,
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<AnalysisBloc, AnalysisState>(
            buildWhen: (previous, current) =>
                current is AnalysisGetAllPaymentSuccess,
            builder: (context, state) {
              AnalysisGetAllPaymentSuccess? data;

              if (state is AnalysisGetAllPaymentSuccess) {
                data = state;
              }
              return HeaderView(
                contextParent: context,
                sumCollect: data?.sumCollect ?? 0,
                sumPay: data?.sumPay ?? 0,
              );
            },
          ),
          Expanded(
            child: BlocBuilder<AnalysisBloc, AnalysisState>(
              buildWhen: (previous, current) =>
                  current is AnalysisGetAllPaymentSuccess,
              builder: (context, state) {
                AnalysisGetAllPaymentSuccess? stateData;
                if (state is AnalysisGetAllPaymentSuccess) {
                  stateData = state;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AnalysisPayView(listData: stateData?.listDataPay ?? []),
                      AnalysisCollectView(
                          listData: stateData?.listDataCollect ?? []),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
