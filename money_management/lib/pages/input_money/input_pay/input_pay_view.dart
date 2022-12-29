part of '../input_money_export.dart';

class InputPayView extends StatefulWidget {
  const InputPayView({super.key});

  @override
  State<InputPayView> createState() => _InputPayViewState();
}

class _InputPayViewState extends State<InputPayView>
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
    return BlocListener<InputMoneyBloc, InputMoneyState>(
      bloc: moneyBloc,
      listenWhen: (previous, current) =>
          current is InputInsertSuccess || current is InputInsertFailure,
      listener: (context, state) {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: InputView(
          bloc: moneyBloc,
          inputType: InputType.pay,
          onSave: (money, category, note, date) {
            moneyBloc.add(InputInsertEvent(
                categoryModel: category,
                note: note,
                dateTime: date,
                type: MoneyType.pay,
                money: money));
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
