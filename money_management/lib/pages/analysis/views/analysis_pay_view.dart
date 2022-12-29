part of '../analysis_export.dart';

class AnalysisPayView extends StatelessWidget {
  const AnalysisPayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        List<MoneyModel> listData = [];
        List<MoneyModel> listDataView = [];

        if (state is AnalysisGetAllPaymentSuccess) {
          listData = state.listData;
          listDataView = state.listData
              .where((element) => element.moneyType == MoneyType.pay)
              .toList();
        }
        return Column(
          children: [
            PieChartView(listData: listData, moneyType: MoneyType.pay),
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listDataView.length,
              itemBuilder: (context, index) {
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
                        border: Border.all(color: ColorConst.border)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: listDataView[index].color!),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                getIconByKey(
                                    listDataView[index].category!.icon!),
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
                            "- ${NumberFormat("#,###", 'vi').format(listDataView[index].money)} VNĐ",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: ColorConst.error),
                          ),
                          const Icon(
                            Icons.navigate_next_outlined,
                            color: ColorConst.text,
                          )
                        ]),
                  ),
                );
              },
            ))
          ],
        );
      },
    );
  }
}
