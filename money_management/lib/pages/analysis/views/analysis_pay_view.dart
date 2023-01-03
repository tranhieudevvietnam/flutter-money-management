part of '../analysis_export.dart';

class AnalysisPayView extends StatelessWidget {
  const AnalysisPayView({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> indexNotifier = ValueNotifier(-1);

    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        List<MoneyModel> listData = [];

        if (state is AnalysisGetAllPaymentSuccess) {
          listData = state.listDataPay;
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              PieChartView(
                listData: listData,
                moneyType: MoneyType.pay,
                onTap: (index) {
                  indexNotifier.value = index;
                },
              ),
              ValueListenableBuilder(
                valueListenable: indexNotifier,
                builder: (context, value, child) {
                  return Column(
                    children: List.generate(listData.length, (index) {
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
                                      ? listData[index].color!
                                      : ColorConst.border)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: listData[index].color!),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(
                                      getIconByKey(
                                          listData[index].category.icon!),
                                      color: listData[index].color!,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${listData[index].category.name}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConst.text),
                                    ),
                                    Text(
                                      "${listData[index].startDate?.dateTimeConvertString(type: "dd/MM/yyyy") ?? "N/A"} - ${listData[index].createDated.dateTimeConvertString(type: "dd/MM/yyyy")}",
                                      style: const TextStyle(
                                          height: 1.5,
                                          fontSize: 12,
                                          color: ColorConst.text),
                                    ),
                                  ],
                                )),
                                Text(
                                  "- ${FormatUtils.instant.moneyFormat(money: listData[index].money)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: value == index ? 16 : 14,
                                      color: ColorConst.error),
                                ),
                                const Icon(
                                  Icons.navigate_next_outlined,
                                  color: ColorConst.text,
                                )
                              ]),
                        ),
                      );
                    }),
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
