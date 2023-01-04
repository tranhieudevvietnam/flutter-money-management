import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_management/constants/color_constant.dart';

enum ToastType { success, fail }

void customToastUtils(
  BuildContext context, {
  String? msg,
  required ToastType type,
}) {
  FToast().init(context).showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: ColorConst.primary,
              border: Border.all(color: ColorConst.primary)),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 5,
            children: [
              _getDynamicIconToast(type),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                msg ?? "Đã có lỗi xảy ra vui lòng thử lại sau",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
}

_getDynamicIconToast(ToastType type) {
  switch (type) {
    case ToastType.fail:
      return const Icon(
        Icons.error_outline,
        color: Colors.white,
      );
    case ToastType.success:
      return const Icon(
        Icons.task_alt_outlined,
        color: Colors.white,
      );

    default:
      return const Icon(
        Icons.error_outline,
        color: Colors.white,
      );
  }
}

Future<void> showMyDiaLog(
    {required BuildContext context,
    required String title,
    required String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Đóng'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
