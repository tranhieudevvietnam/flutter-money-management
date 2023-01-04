// ignore_for_file: prefer_const_literals_to_create_immutables

part of '../input_money_export.dart';

enum InputType { pay, collect }

// ignore: must_be_immutable
class InputView extends StatefulWidget {
  final InputType inputType;
  final InputMoneyBloc bloc;
  final Function(num money, CategoryModel category, String note, DateTime date)
      onSave;
  const InputView(
      {Key? key,
      required this.bloc,
      required this.inputType,
      required this.onSave})
      : super(key: key);

  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  TextEditingController moneyInput = TextEditingController(text: "0");

  TextEditingController noteInput = TextEditingController();

  ValueNotifier<DateTime> dateTimeNotifier = ValueNotifier(DateTime.now());

  ValueNotifier<CategoryModel?> categoryNotifier =
      ValueNotifier<CategoryModel?>(null);

  eventCleanData() {
    moneyInput = TextEditingController(text: "0");
    noteInput.clear();
    dateTimeNotifier.value = DateTime.now();
    categoryNotifier.value = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InputMoneyBloc, InputMoneyState>(
      bloc: widget.bloc,
      listenWhen: (previous, current) =>
          current is InputInsertSuccess || current is InputInsertFailure,
      listener: (context, state) {
        if (state is InputInsertSuccess) {
          showMyDiaLog(context: context, title: "Success", message: "");
          eventCleanData();
        }
        if (state is InputInsertFailure) {
          showMyDiaLog(context: context, title: "Failure", message: "");
        }
      },
      child: Column(
        children: [
          //#region input money
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: widget.inputType == InputType.pay
                        ? ColorConst.error.withOpacity(.5)
                        : ColorConst.success.withOpacity(.5))),
            child: Row(
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  size: 30,
                  color: widget.inputType == InputType.pay
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
                        color: widget.inputType == InputType.pay
                            ? ColorConst.error
                            : ColorConst.success),
                    inputFormatters: [
                      MaskTextInputFormatter(
                        maskTextInputType: MaskTextInputType.money,
                      )
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: const BoxDecoration(
                      border:
                          Border(left: BorderSide(color: ColorConst.border))),
                  child: Text(
                    "VNĐ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.inputType == InputType.pay
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
                          routeName: CategoryScreen.routeName,
                          context: context);
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
                                  Expanded(
                                    child: Text(
                                      "${AppLocalizations.of(context)!.category}...",
                                      style: const TextStyle(
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
                    children: [
                      const Icon(
                        Icons.note_alt_outlined,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            hintText:
                                "${AppLocalizations.of(context)!.note}..."),
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
                              onTap: () async {
                                final dateResult = await DateTimeUtils.instant
                                    .datePicker(context,
                                        dateTimeCurrent:
                                            dateTimeNotifier.value);
                                if (dateResult != null) {
                                  dateTimeNotifier.value = dateResult;
                                }
                                // showMaterialDatePicker(
                                //   context: context,
                                //   selectedDate: dateTimeNotifier.value,
                                //   title: "Select date",
                                //   onChanged: (value) {
                                //     dateTimeNotifier.value = value;
                                //   },
                                //   firstDate:
                                //       DateTime.now().add(Duration(days: -365)),
                                //   lastDate:
                                //       DateTime.now().add(Duration(days: 365)),
                                // );
                              },
                              child: Text(
                                // "${FormatUtils.instant.dateTimeConvertString(date: value, type: "dd/MM/yyyy")}",
                                "${value.dateTimeConvertString(type: "dd/MM/yyyy")}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: dateTimeNotifier,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              final timeResult = await DateTimeUtils.instant
                                  .timePicker(context,
                                      timeCurrent: TimeOfDay(
                                          hour: dateTimeNotifier.value.hour,
                                          minute:
                                              dateTimeNotifier.value.minute));
                              if (timeResult != null) {
                                dateTimeNotifier.value = DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    timeResult.hour,
                                    timeResult.minute);
                              }
                            },
                            child: Text(
                              "${value.dateTimeConvertString(type: "HH:mm")}",
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
              if (int.parse(moneyInput.text.replaceAll(".", "")) <= 0) {
                customToastUtils(context,
                    type: ToastType.success, msg: "Vui lòng nhập số tiền.");
                return;
              }
              widget.onSave.call(
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
              child: Center(
                  child: Text(
                AppLocalizations.of(context)!.save,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
