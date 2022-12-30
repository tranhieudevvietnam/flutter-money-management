part of '../analysis_export.dart';

class AnalysisCollectView extends StatelessWidget {
  const AnalysisCollectView({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> indexNotifier = ValueNotifier(-1);

    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        List<MoneyModel> listData = [];
        List<MoneyModel> listDataView = [];
        if (state is AnalysisGetAllPaymentSuccess) {
          listData = state.listDataCollect;
          listDataView = state.listDataCollect
              .where((element) => element.moneyType == MoneyType.collect)
              .toList();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              PieChartView(
                listData: listData
                    .where((element) => element.moneyType == MoneyType.collect)
                    .toList(),
                moneyType: MoneyType.collect,
                onTap: (index) {
                  indexNotifier.value = index;
                },
              ),
              ValueListenableBuilder(
                valueListenable: indexNotifier,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: List.generate(listDataView.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            NavigatorUtil.push(
                                routeName: AnalysisDetailScreen.routeName,
                                context: context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: value == index ? 2 : 1,
                                    color: value == index
                                        ? listDataView[index].color!
                                        : ColorConst.border)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  listDataView[index].color!),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        getIconByKey(listDataView[index]
                                            .category!
                                            .icon!),
                                        color: listDataView[index].color!,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${listDataView[index].category?.name}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConst.text),
                                  )),
                                  Text(
                                    "+ ${FormatUtils.instant.moneyFormat(money: listDataView[index].money)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: value == index ? 16 : 14,
                                        color: ColorConst.success),
                                  ),
                                  const Icon(
                                    Icons.navigate_next_outlined,
                                    color: ColorConst.text,
                                  )
                                ]),
                          ),
                        );
                      }),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
