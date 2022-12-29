part of '../input_money_export.dart';

class InputCollectView extends StatefulWidget {
  const InputCollectView({super.key});

  @override
  State<InputCollectView> createState() => _InputCollectViewState();
}

class _InputCollectViewState extends State<InputCollectView>
    with AutomaticKeepAliveClientMixin {
  late InputMoneyBloc moneyBloc;

  @override
  void initState() {
    super.initState();
    moneyBloc = BlocProvider.of<InputMoneyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InputView(
        inputType: InputType.collect,
        bloc: moneyBloc,
        onSave: (money, category, note, date) {
          moneyBloc.add(InputInsertEvent(
              categoryModel: category,
              note: note,
              dateTime: date,
              type: MoneyType.collect,
              money: money));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
