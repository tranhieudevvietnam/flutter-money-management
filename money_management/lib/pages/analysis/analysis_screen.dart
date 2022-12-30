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


    bloc= BlocProvider.of<AnalysisBloc>(context);
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(
                  child: AnalysisPayView(),
                ),
                Center(
                  child: AnalysisCollectView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}