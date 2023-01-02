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

  @override
  void initState() {
    super.initState();
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
                    final result =
                        await DateTimeUtils.instant.datePicker(context);
                    debugPrint("data time picker result -> $result");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: ColorConst.primary),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            FormatUtils.instant.dateTimeConvertString(
                                date: DateTime.now(), type: "dd/MM/yyyy"),
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "1 Tuần",
                  style: TextStyle(fontSize: 16),
                )),
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
