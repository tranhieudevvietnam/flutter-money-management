import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/domain/moneys/entities/money_model.dart';
import 'package:money_management/domain/moneys/entities/money_type.dart';

import 'pie_chart_data.dart';
import 'pie_chart_paint.dart';

// ignore: must_be_immutable
class PieChartView extends StatefulWidget {
  List<MoneyModel> listData;
  final MoneyType moneyType;
  final Function(int index) onTap;
  PieChartView(
      {super.key,
      required this.listData,
      required this.moneyType,
      required this.onTap});

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  int touchedIndex = -1;
  Offset? position;

  double height = 0.0;
  double width = 0.0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 3;
    width = MediaQuery.of(context).size.width;
    final customPaint = PieChartPaint(
      context: context,
      callBackTouch: (pieSelected, index) {
        widget.onTap.call(index);
        setState(() {
          touchedIndex = index;
        });
      },
      sections: showingSections(),
      sectionsSpace: 0,
      centerSpaceRadius: 20,
    );

    return SizedBox(
      height: height,
      width: width,
      child: Listener(
        onPointerDown: (event) {
          RenderBox? renderBox = context.findRenderObject() as RenderBox;
          final position = renderBox.globalToLocal(event.position);
          customPaint.handleTouch(
            position,
          );
        },
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 300),
          painter: customPaint,
        ),
      ),
    );
  }

  List<PieChartData> showingSections() {
    if (widget.listData.isEmpty) {
      return [
        PieChartData(
          color: ColorConst.hintText,
          value: 100,
          radius: (height / 3 - 10),
          borderSide: const BorderSide(width: 1, color: Colors.white),
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        )
      ];
    }
    return List.generate(widget.listData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? (height / 2.5) : (height / 2.5 - 20);
      return PieChartData(
        color: widget.listData[i].color!,
        value: widget.listData[i].percent!.toDouble(),
        title: '${widget.listData[i].percent!.round()}%',
        radius: radius,
        borderSide: const BorderSide(width: 1, color: Colors.white),
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }
}
