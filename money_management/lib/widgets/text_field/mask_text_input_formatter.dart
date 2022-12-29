import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum MaskTextInputType {
  number,
  money,
  percent,
  none,
  weight,
}

class MaskTextInputFormatter implements TextInputFormatter {
  final MaskTextInputType maskTextInputType;
  final String? mask;
  final num? maxNumber;

  MaskTextInputFormatter(
      {required this.maskTextInputType, this.mask, this.maxNumber});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      debugPrint("newValue: ${newValue.text}");
      String newText = "";
      if (maskTextInputType == MaskTextInputType.none) {
      } else if ((maskTextInputType == MaskTextInputType.number ||
          maskTextInputType == MaskTextInputType.money ||
          maskTextInputType == MaskTextInputType.weight)) {
        String? textTemp;

        textTemp = newValue.text
            .replaceAll("..", "")
            .replaceAll(".", "")
            .replaceAll(",", "")
            .replaceAll("-", "");

        final numberConvert = num.parse(textTemp.isNotEmpty ? textTemp : "0");
        if (maxNumber != null && numberConvert > maxNumber!) {
          newText = oldValue.text;
        } else {
          newText = NumberFormat(mask ?? "#,###", 'vi').format(numberConvert);
        }

        // debugPrint("_newText: ${_newText}");
        // debugPrint("_textTemp: ${_textTemp}");
        // if (textTemp.isEmpty) {
        //   newText = newText.replaceAll("0", "");
        // }

        return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length));
      }
      if (maskTextInputType == MaskTextInputType.percent) {
        return getTextEditingPercent(
            oldValue: oldValue, newValue: newValue, max: maxNumber?.toDouble());
      }
      return newValue;
    } catch (error) {
      debugPrint(error.toString());
      return oldValue;
    }
  }

  getTextEditingPercent(
      {required TextEditingValue oldValue,
      required TextEditingValue newValue,
      double? max}) {
    // TextSelection newSelection = newValue.selection;
    String truncated = newValue.text.replaceAll("%", "");
    const decimalRange = 2;
    // final aaa = truncated.split(".");

    if (truncated.split(".").first.length > 1 && truncated.indexOf("0") == 0) {
      truncated = truncated.substring(truncated.indexOf("0") + 1);
    }

    String value = newValue.text.replaceAll("%", "");

    try {
      if ((value.contains(".") &&
              value.substring(value.indexOf(".") + 1).length > decimalRange) ||
          double.parse(value) > (max ?? 0)) {
        truncated = oldValue.text.replaceAll("%", "");
        // newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        // newSelection = newValue.selection.copyWith(
        //   baseOffset: math.min(truncated.length, truncated.length + 1),
        //   extentOffset: math.min(truncated.length, truncated.length + 1),
        // );
      }

      return TextEditingValue(
        text: "$truncated%",
        // selection: TextSelection.collapsed(
        //           offset: truncated.length -1),
        // composing: TextRange.empty,
      );
    } on Exception {
      return const TextEditingValue(
        text: "0%",
      );
    }
  }
}
