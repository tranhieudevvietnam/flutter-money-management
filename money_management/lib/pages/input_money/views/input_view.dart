import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/domain/categories/entities/category_model.dart';
import 'package:money_management/pages/categories/category_export.dart';
import 'package:money_management/utils/custom_toast_utils.dart';
import 'package:money_management/utils/format_utils.dart';
import 'package:money_management/utils/navigator_utils.dart';
import 'package:money_management/widgets/text_field/mask_text_input_formatter.dart';

enum InputType { pay, collect }

// ignore: must_be_immutable
class InputView extends StatelessWidget {
  final InputType inputType;
  final Function(num money, CategoryModel category, String note, DateTime date)
      onSave;
  InputView({Key? key, required this.inputType, required this.onSave})
      : super(key: key);

  TextEditingController moneyInput = TextEditingController(text: "0");
  TextEditingController noteInput = TextEditingController();

  ValueNotifier<DateTime> dateTimeNotifier = ValueNotifier(DateTime.now());

  ValueNotifier<CategoryModel?> categoryNotifier =
      ValueNotifier<CategoryModel?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //#region input money
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: inputType == InputType.pay
                      ? ColorConst.error.withOpacity(.5)
                      : ColorConst.success.withOpacity(.5))),
          child: Row(
            children: [
              Icon(
                Icons.attach_money_outlined,
                color: inputType == InputType.pay
                    ? ColorConst.error
                    : ColorConst.success,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: moneyInput,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      maskTextInputType: MaskTextInputType.money,
                    )
                  ],
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Enter money.."),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: ColorConst.border))),
                child: Text(
                  "VND",
                  style: TextStyle(
                      fontSize: 16,
                      color: inputType == InputType.pay
                          ? ColorConst.error
                          : ColorConst.success),
                ),
              )
            ],
          ),
        ),
        //#endregion
        Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConst.border)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    NavigatorUtil.push(
                        routeName: CategoryInputScreen.routeName,
                        context: context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.format_list_bulleted_outlined),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ValueListenableBuilder(
                        valueListenable: categoryNotifier,
                        builder: (context, value, child) {
                          if (value == null) {
                            return const Text(
                              "Categories....",
                              style: TextStyle(color: ColorConst.hintText),
                            );
                          } else {
                            return Text(
                              value.name ?? "N/A",
                              style:
                                  const TextStyle(color: ColorConst.hintText),
                            );
                          }
                        },
                      )),
                      const Icon(Icons.navigate_next_outlined),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: const [
                    Icon(Icons.note_alt_outlined),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          hintText: "Enter note..."),
                    )),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ValueListenableBuilder(
                      valueListenable: dateTimeNotifier,
                      builder: (context, value, child) {
                        return Text(
                            "${FormatUtils.instant.dateTimeConvertString(date: value)}");
                      },
                    )),
                    const Icon(Icons.navigate_next_outlined),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            if (categoryNotifier.value == null) {
              customToastUtils(context,
                  type: ToastType.success, msg: "Vui lòng chọn danh mục.");
              return;
            }
            onSave.call(num.parse(moneyInput.text), categoryNotifier.value!,
                noteInput.text, dateTimeNotifier.value);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: inputType == InputType.pay
                    ? ColorConst.error
                    : ColorConst.success,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: inputType == InputType.pay
                        ? ColorConst.error
                        : ColorConst.success)),
            child: const Center(
                child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )),
          ),
        )
      ],
    );
  }
}
