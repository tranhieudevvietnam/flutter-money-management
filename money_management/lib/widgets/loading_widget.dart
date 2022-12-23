import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money_management/constants/color_constant.dart';

class LoadingWidget extends StatelessWidget {
  final bool notData;
  final String? title;
  final String? titleNotData;

  const LoadingWidget(
      {Key? key, this.notData = false, this.title, this.titleNotData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitCircle(
      color: ColorConst.primary,
      size: 30.0,
    );

    return Center(
      child: notData == true
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titleNotData ?? "Không còn dữ liệu để hiển thị.",
                style: const TextStyle(color: ColorConst.text),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: spinKit,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? "Đang tải...",
                  style: const TextStyle(color: ColorConst.text),
                ),
              ],
            ),
    );
  }
}
