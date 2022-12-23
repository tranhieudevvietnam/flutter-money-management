part of '../input_money_export.dart';

class InputPayView extends StatefulWidget {
  const InputPayView({super.key});

  @override
  State<InputPayView> createState() => _InputPayViewState();
}

class _InputPayViewState extends State<InputPayView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InputView(
        inputType: InputType.pay,
        onSave: (money, category, note, date) {
          
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
