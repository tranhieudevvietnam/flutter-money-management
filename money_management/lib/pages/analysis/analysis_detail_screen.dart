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
      appBar: BasicAppBar(
          "${AppLocalizations.of(context)!.detail} ${AppLocalizations.of(context)!.analysis.toLowerCase()}"),
      body: SafeArea(
          child: BlocBuilder<AnalysisBloc, AnalysisState>(
        buildWhen: (previous, current) => current is AnalysisDetailState,
        builder: (context, stateParent) {
          List<List<ChartModel>> listDataChart = [];
          List<MoneyModel> listData = [];
          if (stateParent is AnalysisDetailState) {
            listDataChart.add(stateParent.listCharts);
            listData = stateParent.listData;
          }
          return Column(
            children: [
              ChartsLine(
                height: 200,
                colorSelect: ColorConst.primary,
                onTap: (indexParent, indexChild) {
                  bloc.add(AnalysisDetailByMonthEvent(
                      data: widget.moneyModel,
                      date: listDataChart[indexParent][indexChild].date));
                },
                style: const TextStyle(fontSize: 10),
                listData: listDataChart,
              ),
              Expanded(
                child: BlocBuilder<AnalysisBloc, AnalysisState>(
                  buildWhen: (previous, current) =>
                      current is AnalysisDetailByMonthState ||
                      current is AnalysisDetailState,
                  builder: (context, state) {
                    if (state is AnalysisDetailByMonthState) {
                      listData = state.listData;
                    }
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: List.generate(
                          listData.length,
                          (index) => Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1, color: ColorConst.border)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: getColorByType()),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Icon(
                                            getIconByKey(
                                                listData[index].category.icon!),
                                            color: getColorByType(),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${listData[index].category.name}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: ColorConst.text),
                                          ),
                                          Text(
                                            "${listData[index].createDated.dateTimeConvertString(type: "HH:mm dd/MM/yyyy")}",
                                            style: const TextStyle(
                                                height: 1.5,
                                                fontSize: 12,
                                                color: ColorConst.text),
                                          ),
                                        ],
                                      )),
                                      Text(
                                        "${FormatUtils.instant.moneyFormat(money: listData[index].money)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: getColorByType()),
                                      ),
                                      const Icon(
                                        Icons.navigate_next_outlined,
                                        color: ColorConst.text,
                                      )
                                    ]),
                              )),
                    );
                  },
                ),
              )
            ],
          );
        },
      )),
    );
  }

  getColorByType() {
    return widget.moneyModel.moneyType == MoneyType.pay
        ? ColorConst.error
        : ColorConst.success;
  }
}
