import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';

class InputCollectView extends StatelessWidget {
  const InputCollectView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    debugPrint("1111: ${queryData.devicePixelRatio}");
    return Column(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 2),
          painter: ShapePainter(),
        )
      ],
    );
  }
}

class ShapePainter extends CustomPainter {
  final textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  late Size mainSize;

  @override
  void paint(Canvas canvas, Size size) {
    mainSize = size;
    var paint = Paint()
      ..color = ColorConst.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(size.width / 2, 50);
    path.lineTo((size.width / 2) - 50, 150);
    path.lineTo((size.width / 2) + 50, 150);
    path.lineTo(size.width / 2, 50);

    canvas.drawPath(path, paint);

    debugPrint("xxx: $size");

    String aaaa =
        "cần một Offset là tọa độ cần một Offset là tọa độ tọa độ cần một Offset là tọa độ tọa độ cần một Offset là tọa độ tọa độ cần một Offset là tọa độ tọa độ cần một Offset là tọa độ tọa độ cần một Offset là tọa độ";
    final listText = aaaa.split(" ");
    renderText(
        canvas: canvas,
        index: 0,
        width: (size.width / 2),
        dx: 0,
        dy: 50,
        listText: listText,
        size: size);
  }

  renderText(
      {required Canvas canvas,
      required int index,
      required double width,
      required Size size,
      required double dx,
      required double dy,
      required List<String> listText}) {
    final textSpan = TextSpan(
      text: listText[index],
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    final x = dx + (listText[index].length + 1) * (16 / 1.8);
    debugPrint("length: ${listText[index].length}");
    debugPrint("x: $x");
    if (x > width) {
      if (index < listText.length) {
        if ((dy + 25) > 150) {
          renderText(
              canvas: canvas,
              index: index,
              dx: 0,
              width: mainSize.width,
              dy: dy + 25,
              listText: listText,
              size: Size(mainSize.width, size.height));
        } else {
          renderText(
              canvas: canvas,
              index: index,
              dx: 0,
              width: (size.width / 2),
              dy: dy + 25,
              listText: listText,
              size: Size(size.width - 30, size.height));
        }
      }
    } else {
      textPainter.layout(
        minWidth: 0,
        maxWidth: x,
      );
      final offset = Offset(dx, dy);
      textPainter.paint(canvas, offset);
      if (index + 1 < listText.length) {
        renderText(
            canvas: canvas,
            index: index + 1,
            width: width,
            dx: x,
            dy: dy,
            listText: listText,
            size: size);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
