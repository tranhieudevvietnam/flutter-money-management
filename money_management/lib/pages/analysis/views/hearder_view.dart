part of '../analysis_export.dart';

class AnimatedItem extends AnimatedWidget {
  final String title;
  final num money;
  final Color color;
  const AnimatedItem(
      {super.key,
      required Animation<double> animation,
      required this.title,
      required this.money,
      required this.color})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  static final _sizeTween = Tween<double>(begin: 0, end: 30);
  static final _heightTween = Tween<double>(begin: 0, end: 40);

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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: ColorConst.text),
            ),
          ),
          Text(
            FormatUtils.instant.moneyFormat(money: money),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class AnimationMore extends AnimatedWidget {
  AnimationMore({super.key, required super.listenable});
  final _transformTween = Tween<double>(begin: 0, end: 180);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          textAlign: TextAlign.start,
          _transformTween.evaluate(animation) == 180
              ? "Thu gọn"
              : "Xem thống kê",
          style: const TextStyle(
            fontSize: 14,
            color: ColorConst.primary,
          ),
        ),
        Transform.rotate(
            angle: _transformTween.evaluate(animation) * math.pi / 180,
            child: const Icon(
              Icons.expand_more_outlined,
              color: ColorConst.primary,
              size: 20,
            )),
      ],
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
  late AnimationController controller1;

  AnimationStatus? status;

  List<GroupDateTimeModel> listGroupDateTime = [];
  GroupDateTimeModel? groupDateSelected;
  late AnalysisBloc bloc;
  ValueNotifier<DateTime> dateSelected = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AnalysisBloc>(context);

    listGroupDateTime = [
      GroupDateTimeModel(title: "1 Tuần", valueDay: 7),
      GroupDateTimeModel(title: "2 Tuần", valueDay: 14),
      GroupDateTimeModel(title: "3 Tuần", valueDay: 21),
      GroupDateTimeModel(
          title: "1 Tháng", valueDay: DateTime.now().daysInMonth),
    ];
    groupDateSelected = listGroupDateTime.last;
    bloc.add(AnalysisInitEvent(
        dateTime: dateSelected.value, day: groupDateSelected!.valueDay));

    controller1 = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn)
      ..addStatusListener((status) {
        this.status = status;
      });

    controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final result = await DateTimeUtils.instant.datePicker(
                        context,
                        dateTimeCurrent: dateSelected.value);
                    if (result != null) {
                      dateSelected.value = result;
                      bloc.add(AnalysisInitEvent(
                          dateTime: dateSelected.value,
                          day: groupDateSelected?.valueDay));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ValueListenableBuilder(
                      valueListenable: dateSelected,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: ColorConst.primary),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                // FormatUtils.instant.dateTimeConvertString(
                                //     date: dateSelected, type: "dd/MM/yyyy"),
                                value.dateTimeConvertString(type: "dd/MM/yyyy"),
                                style: const TextStyle(fontSize: 16)),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              DropdownWidget(
                listData: listGroupDateTime,
                data: groupDateSelected,
                onChange: (value) {
                  groupDateSelected = value;
                  bloc.add(AnalysisInitEvent(
                      dateTime: dateSelected.value,
                      day: groupDateSelected?.valueDay));
                },
                builderDropdownItem: (context, data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          data?.title ?? "N/A",
                          style: const TextStyle(
                              fontSize: 16, color: ColorConst.primary),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.expand_more_outlined,
                          color: ColorConst.primary,
                          size: 20,
                        )
                      ],
                    ),
                  );
                },
                builderDropdownItemMenu: (context, data) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data?.title ?? "N/A",
                      style: const TextStyle(
                          fontSize: 16, color: ColorConst.primary),
                    ),
                  );
                },
              )
            ],
          ),
          AnimatedItem(
            animation: animation1,
            money: widget.sumPay,
            title: "Spending: ",
            color: ColorConst.error,
          ),
          AnimatedItem(
            animation: animation1,
            money: widget.sumCollect,
            title: "Income: ",
            color: ColorConst.success,
          ),
          AnimatedItem(
            animation: animation1,
            money: widget.sumCollect - widget.sumPay,
            title: "Surplus: ",
            color: ColorConst.text,
          ),
          GestureDetector(
            onTap: () {
              if (status == AnimationStatus.completed) {
                controller1.reverse();
              } else if (status == AnimationStatus.dismissed) {
                controller1.forward();
              }
            },
            child: AnimationMore(listenable: animation1),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }
}
