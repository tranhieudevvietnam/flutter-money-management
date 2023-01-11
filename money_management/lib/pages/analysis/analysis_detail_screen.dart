part of 'analysis_export.dart';

class AnalysisDetailScreen extends StatefulWidget {
  static const String routeName = "/analysis/detail/screen";
  final MoneyModel moneyModel;

  const AnalysisDetailScreen({super.key, required this.moneyModel});

  @override
  State<AnalysisDetailScreen> createState() => _AnalysisDetailScreenState();
}

class _AnalysisDetailScreenState extends State<AnalysisDetailScreen> {
  late AnalysisBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AnalysisBloc>(context);
    bloc.add(AnalysisDetailEvent(widget.moneyModel));

    // bloc = BlocProvider.of<AnalysisBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar("Analysis Detail"),
      body: SafeArea(
          child: Column(
        children: [
          BlocBuilder<AnalysisBloc, AnalysisState>(
            buildWhen: (previous, current) => current is AnalysisDetailState,
            builder: (context, state) {
              List<List<ChartModel>> listData = [];
              if (state is AnalysisDetailState) {
                listData.add(state.listCharts);
              }
              return ChartsLine(
                height: 300,
                colorSelect: Colors.grey,
                onTap: (index) {
                  // todayMoney = listData[1][index].value;
                  // tomorrowMoney = listData[0][index].value;
                  // _streamController.sink.add(null);
                },
                style: const TextStyle(fontSize: 10),
                listData: listData,
              );
            },
          ),
        ],
      )),
    );
  }
}
