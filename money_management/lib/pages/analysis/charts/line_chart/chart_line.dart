import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ChartModel {
  final String time;
  num value;
  final Color color;
  final DateTime date;

  ChartModel(
      {required this.time, required this.value, required this.date, this.color = Colors.black});
}

// ignore: must_be_immutable
class ChartsLine extends StatefulWidget {
  final List<List<ChartModel>> listData;
  Color color;
  Color colorSelect;
  Function(int indexParent, int indexChild)? onTap;

  TextStyle? style;
  double? height;

  ChartsLine(
      {Key? key,
      required this.listData,
      this.height,
      this.style,
      this.onTap,
      this.color = Colors.black,
      this.colorSelect = Colors.grey})
      : super(key: key);

  @override
  State<ChartsLine> createState() => _ChartsLineState();
}

class _ChartsLineState extends State<ChartsLine> {
  Offset? position;
  double paddingX = 10;
  double paddingY = 16;

  @override
  Widget build(BuildContext context) {
    // print("posision: ${position}");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingY, horizontal: paddingX),
      child: SizedBox(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        child: Listener(
          onPointerMove: (event) {
            RenderBox? renderBox = context.findRenderObject() as RenderBox;
            final aaa = Offset(
                event.position.dx - paddingX, event.position.dy - paddingY);
            final positionTemp = renderBox.globalToLocal(aaa);
            setState(() {
              position = Offset(positionTemp.dx, positionTemp.dy);
            });
          },
          onPointerDown: (event) {
            RenderBox? renderBox = context.findRenderObject() as RenderBox;
            final aaa = Offset(
                event.position.dx - paddingX, event.position.dy - paddingY);
            final positionTemp = renderBox.globalToLocal(aaa);
            setState(() {
              position = Offset(positionTemp.dx, positionTemp.dy);
            });
          },
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width - 32,
                (widget.height ?? 300) - 32),
            painter: MyCustomPaint(
                listData: widget.listData,
                color: widget.color,
                onTap: widget.onTap,
                colorSelect: widget.colorSelect,
                position: position),
          ),
        ),
      ),
    );
  }
}

class MyCustomPaint extends CustomPainter {
  List<List<ChartModel>> listData;
  Color color;
  TextStyle? style;
  double? height;
  Offset? position;
  Color colorSelect;
  Function(int indexParent, int indexChild)? onTap;

  MyCustomPaint(
      {required this.listData,
      this.height,
      this.style,
      this.position,
      this.onTap,
      this.colorSelect = Colors.grey,
      this.color = Colors.black})
      : super();

  static const double paddingX = 60;
  static const double paddingY = 10;
  double jump = 20;

  @override
  void paint(Canvas canvas, Size size) {
    int length = 0;

    List<ChartModel> listChartDefault = [];
    double max = 0;
    for (var item in listData) {
      var listData2 = item;
      var max2 = (listData2.reduce((a, b) => a.value > b.value ? a : b))
          .value
          .toDouble();
      max = max2 > max ? max2 : max;
      length = item.length > length ? item.length : length;
      item = listData2;
      listChartDefault =
          item.length > listChartDefault.length ? item : listChartDefault;
    }

    jump = max / 5;

    double widthNext = (size.width - paddingX) / length;
    double heightNext = (size.height / (max / jump)) - paddingY / 1.5;

    ///paint c??c gi?? tr??? h??ng c???t ( line v?? text)
    _initDrawTextLeftColumn(
        canvas: canvas, size: size, valueNext: heightNext, maxValue: max);

    ///paint c??c gi?? tr??? h??ng ngang ( line v?? text)
    _initDrawTextLeftRow(
      canvas: canvas,
      size: size,
      listData: listChartDefault,
      valueNext: widthNext,
    );

    for (int i = 0; i < listData.length; i++) {
      final item = listData[i];
      //L???y list to??? ????? d??ng cho vi???c ch???m ??i???m v?? v??? line
      List<Offset> listOffset = _getListOffsetByListData(
          listData: item,
          heightNext: heightNext,
          size: size,
          widthNext: widthNext);

      const pointMode = ui.PointMode.points;

      final paintClick = Paint()
        ..color = colorSelect
        ..strokeWidth = 2;

      final paint = Paint()
        ..color = item.first.color
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      for (int iii = 0; iii < listOffset.length; iii++) {
        /// shadow cho c??c point
        var path = Path()
          ..addOval(Rect.fromCircle(center: listOffset[iii], radius: 4.0));
        canvas.drawShadow(path, const Color(0xff000000), 5, true);

        if (position != null &&
            (position!.dx >= (listOffset[iii].dx - widthNext / 2) &&
                position!.dx <= (listOffset[iii].dx + widthNext / 2)) &&
            onTap != null) {
          onTap?.call(i, iii);
          canvas.drawLine(
              Offset(listOffset[iii].dx, 0),
              Offset(listOffset[iii].dx, size.height - paddingY * 2),
              paintClick);
        }
      }

      ///line gi???a c??c position
      final paint2 = Paint()
        ..color = item.first.color
        ..strokeWidth = 3;

      // Path pathBelow = Path();
      for (int i = 0; (i + 1) < listOffset.length; i++) {
        canvas.drawLine(listOffset[i], listOffset[i + 1], paint2);
      }

      //#region below color line

      // Paint barAreaPaint = Paint()
      //   ..style = PaintingStyle.fill
      //   ..color = item.first.color.withOpacity(.2);
      // pathBelow.moveTo(listOffset.first.dx, listOffset.first.dy);

      // for (int i = 0; (i + 1) < listOffset.length; i++) {
      //   canvas.drawLine(listOffset[i], listOffset[i + 1], paint2);
      //   pathBelow.lineTo(listOffset[i + 1].dx, listOffset[i + 1].dy);
      //   if ((i + 1) == listOffset.length - 1) {
      //     pathBelow.lineTo(listOffset[i + 1].dx, size.height - paddingY);
      //   }
      // }
      // pathBelow.lineTo(paddingX, size.height - paddingY);

      // canvas.drawPath(pathBelow, barAreaPaint);

      //#endregion
      canvas.drawPoints(pointMode, listOffset, paint);
      // canvas.save();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return true;
  }

  _getListOffsetByListData(
      {required Size size,
      required List<ChartModel> listData,
      required double heightNext,
      required double widthNext}) {
    List<Offset> listOffset = [];
    _getOffsetByListData(
        size: size,
        listData: listData,
        heightNext: heightNext,
        valueNext: widthNext,
        x: paddingX,
        index: 0,
        listOffset: listOffset);
    // print("xxxx---${listOffset}");
    return listOffset;
  }

  _getOffsetByListData(
      {required Size size,
      required List<ChartModel> listData,
      required double heightNext,
      required double valueNext,
      required int index,
      required List<Offset> listOffset,
      double x = paddingX}) {
    var dy = heightNext / (jump / listData[index].value.toDouble()) +
        (paddingY * 1.5);
    var dy2 = (size.height - paddingY) - dy;
    listOffset.add(Offset(x, dy2));
    if (index + 1 < listData.length) {
      _getOffsetByListData(
          size: size,
          listData: listData,
          heightNext: heightNext,
          listOffset: listOffset,
          index: index + 1,
          valueNext: valueNext,
          x: x + valueNext);
    }
  }

  void _drawDashedLine(Canvas canvas, Size size, double dy, Paint paint,
      {double? start}) {
    // Chage to your preferred size
    const int dashWidth = 1;
    const int dashSpace = 5;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = start ?? 0;
    double y = dy;
    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }

  _initDrawTextLeftColumn({
    required Canvas canvas,
    required Size size,
    double y = 0,
    int index = 0,
    required double valueNext,
    required double maxValue,
  }) {
    if ((maxValue - (index * jump)) >= 0) {
      final Paint paint3 = Paint()
        ..color = const Color(0xffE7E7E8)
        ..strokeCap = StrokeCap.square
        ..strokeWidth = 1.5;
      _drawDashedLine(canvas, size, y + paddingY, paint3, start: paddingX);
      // ignore: prefer_const_constructors
      final textStyle = TextStyle(
        color: color,
        fontSize: 10,
      );

      final textSpan = TextSpan(
        text: "${formatNumberThousand((maxValue - (index * jump)).toInt())} ??",
        style: style ?? textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        // minWidth: 0,
        maxWidth: paddingX,
      );
      // final xCenter = (size.width - textPainter.width) / 2;
      // final yCenter = (size.height - textPainter.height) / 2;
      final offset = Offset(0, y);
      textPainter.paint(canvas, offset);
      _initDrawTextLeftColumn(
          canvas: canvas,
          size: size,
          valueNext: valueNext,
          maxValue: maxValue,
          index: index + 1,
          y: y + valueNext);
    }
  }

  _initDrawTextLeftRow({
    required Canvas canvas,
    required Size size,
    double x = paddingX,
    required List<ChartModel> listData,
    int index = 1,
    required double valueNext,
  }) {
    // ignore: prefer_const_constructors
    final textStyle = TextStyle(
      color: color,
      fontSize: 10,
    );
    final textSpan = TextSpan(
      text: listData[index - 1].time,
      style: style ?? textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      // minWidth: 0,
      maxWidth: paddingX,
    );
    final offset = Offset(x - 2, size.height - paddingY);
    textPainter.paint(canvas, offset);

    if (index < listData.length) {
      _initDrawTextLeftRow(
          canvas: canvas,
          size: size,
          listData: listData,
          valueNext: valueNext,
          index: index + 1,
          x: x + valueNext);
    }
  }
}

String formatNumberThousand(int number) {
  return intl.NumberFormat.compact(
    locale: "vi",
  ).format(number);
}
