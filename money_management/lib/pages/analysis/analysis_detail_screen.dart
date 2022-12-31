part of 'analysis_export.dart';

class AnalysisDetailScreen extends StatefulWidget {
  static const String routeName = "/analysis/detail/screen";

  const AnalysisDetailScreen({super.key});

  @override
  State<AnalysisDetailScreen> createState() => _AnalysisDetailScreenState();
}

class _AnalysisDetailScreenState extends State<AnalysisDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<List<ChartModel>> listData = [];
    listData = [
      [
        ChartModel(time: "T1", value: 40000, color: Colors.green.shade300),
        ChartModel(time: "T2", value: 50000),
        ChartModel(time: "T3", value: 10000),
        ChartModel(time: "T4", value: 20000),
        ChartModel(time: "T5", value: 60000),
        ChartModel(time: "T6", value: 90000),
        ChartModel(time: "T7", value: 40000),
      ],
      [
        ChartModel(time: "T1", value: 60000, color: Colors.red.shade300),
        ChartModel(time: "T2", value: 80000),
        ChartModel(time: "T3", value: 50000),
        ChartModel(time: "T4", value: 40000),
        ChartModel(time: "T5", value: 60000),
        ChartModel(time: "T6", value: 60000),
        ChartModel(time: "T7", value: 50000),
      ],
    ];

    return Scaffold(
      appBar: const BasicAppBar("Analysis Detail"),
      body: SafeArea(
          child: Column(
        children: [
          ChartsLine(
            height: 300,
            colorSelect: Colors.grey,
            onTap: (index) {
              // todayMoney = listData[1][index].value;
              // tomorrowMoney = listData[0][index].value;
              // _streamController.sink.add(null);
            },
            style: const TextStyle(fontSize: 10),
            listData: listData,
          ),
        ],
      )),
    );
  }
}
