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
  final _transformTween = Tween<double>(begin: 180, end: 0);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
            angle: _transformTween.evaluate(animation) * math.pi / 180,
            child: const Icon(
              Icons.expand_more_outlined,
              color: ColorConst.primary,
              size: 20,
            )),
        Text(
          _transformTween.evaluate(animation) == 180 ? "Xem thêm" : "Thu gọn",
          style: const TextStyle(
            fontSize: 12,
            color: ColorConst.primary,
          ),
        )
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
  late Animation<double> animation2;
  late Animation<double> animation3;
  late AnimationController controller1;
  // late AnimationController controller2;
  // late AnimationController controller3;

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
