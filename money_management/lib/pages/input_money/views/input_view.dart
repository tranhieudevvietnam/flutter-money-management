// ignore_for_file: prefer_const_literals_to_create_immutables

part of '../input_money_export.dart';

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
                size: 30,
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: inputType == InputType.pay
                          ? ColorConst.error
                          : ColorConst.success),
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
                      fontWeight: FontWeight.bold,
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
                  onTap: () async {
                    final result = await NavigatorUtil.push(
                        routeName: CategoryScreen.routeName, context: context);
                    if (result != null && result is CategoryModel) {
                      categoryNotifier.value = result;
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: ValueListenableBuilder(
                        valueListenable: categoryNotifier,
                        builder: (context, value, child) {
                          if (value == null) {
                            return Row(
                              children: [
                                const Icon(
                                  Icons.format_list_bulleted_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Expanded(
                                  child: Text(
                                    "Categories....",
                                    style: TextStyle(
                                        color: ColorConst.hintText,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                Icon(
                                  getIconByKey(value.icon!),
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    value.name ?? "N/A",
                                    style: const TextStyle(
                                        color: ColorConst.text, fontSize: 14),
                                  ),
                                ),
                              ],
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
                    Icon(
                      Icons.note_alt_outlined,
                      size: 30,
                    ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: dateTimeNotifier,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              showMaterialDatePicker(
                                context: context,
                                selectedDate: dateTimeNotifier.value,
                                onChanged: (value) {
                                  dateTimeNotifier.value = value;
                                },
                                firstDate:
                                    DateTime.now().add(Duration(days: -365)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                              );
                            },
                            child: Text(
                              "${FormatUtils.instant.dateTimeConvertString(date: value, type: "dd/MM/yyyy")}",
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: dateTimeNotifier,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            var time = TimeOfDay.now();
                            showMaterialTimePicker(
                              context: context,
                              selectedTime: time,
                              onChanged: (value) {
                                final dateTimeTemp = dateTimeNotifier.value;
                                dateTimeNotifier.value = DateTime(
                                    dateTimeTemp.year,
                                    dateTimeTemp.month,
                                    dateTimeTemp.day,
                                    value.hour,
                                    value.minute);
                              },
                            );
                          },
                          child: Text(
                            "${FormatUtils.instant.dateTimeConvertString(date: value, type: "HH:mm")}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      },
                    ),
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
            onSave.call(
                num.parse(moneyInput.text.replaceAll(".", "")),
                categoryNotifier.value!,
                noteInput.text,
                dateTimeNotifier.value);
          },
          child: Container(
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
          ),
        )
      ],
    );
  }
}
