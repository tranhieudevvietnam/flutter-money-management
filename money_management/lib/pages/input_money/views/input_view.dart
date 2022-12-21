import 'package:flutter/material.dart';
import 'package:money_management/constants/color_constant.dart';
import 'package:money_management/utils/format_utils.dart';
import 'package:money_management/widgets/text_field/mask_text_input_formatter.dart';

class InputView extends StatelessWidget {
  const InputView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //#region input money
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorConst.border)),
          child: Row(
            children: [
              const Icon(Icons.attach_money_outlined),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
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
                child: const Text("VND"),
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
                Row(
                  children: const [
                    Icon(Icons.format_list_bulleted_outlined),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(child: Text("Categories....")),
                    Icon(Icons.navigate_next_outlined),
                  ],
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
                        child: Text(
                            "${FormatUtils.instant.dateTimeConvertString(date: DateTime.now())}")),
                    const Icon(Icons.navigate_next_outlined),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: ColorConst.primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorConst.primary)),
          child: const Center(
              child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          )),
        )
      ],
    );
  }
}
