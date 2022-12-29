part of 'analysis_export.dart';

class AnalysisDetailScreen extends StatefulWidget {
  static const String routeName= "/analysis/detail/screen";

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
        ChartModel(
            time: "T1",
            value: Random().nextInt(10000000),
            color: Colors.blue.shade300),
        ChartModel(time: "T2", value: Random().nextInt(10000000)),
        ChartModel(time: "T3", value: Random().nextInt(10000000)),
        ChartModel(time: "T4", value: Random().nextInt(10000000)),
        ChartModel(time: "T5", value: Random().nextInt(10000000)),
        ChartModel(time: "T6", value: Random().nextInt(10000000)),
        ChartModel(time: "T7", value: Random().nextInt(10000000)),
        ChartModel(time: "T8", value: Random().nextInt(10000000)),
        ChartModel(time: "T9", value: Random().nextInt(10000000)),
        ChartModel(time: "T10", value: Random().nextInt(10000000)),
        ChartModel(time: "T11", value: Random().nextInt(10000000)),
        ChartModel(time: "T12", value: Random().nextInt(10000000)),
      ],
      // [
      //   ChartModel(
      //       time: "T1",
      //       value: Random().nextInt(100000000),
      //       color: Colors.red.shade300),
      //   ChartModel(time: "T2", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T3", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T4", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T5", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T6", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T7", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T8", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T9", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T10", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T11", value: Random().nextInt(100000000)),
      //   ChartModel(time: "T12", value: Random().nextInt(100000000)),
      // ],
    ];

    return Scaffold(
      appBar: const BasicAppBar("Analysis Detail"),
      body: SafeArea(
          child: Column(
        children: [
          ChartsLine(
            height: 300,
            colorSelect: Colors.yellow,
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
