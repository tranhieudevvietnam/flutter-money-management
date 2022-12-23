part of '../input_money_export.dart';

class InputCollectView extends StatefulWidget {
  const InputCollectView({super.key});

  @override
  State<InputCollectView> createState() => _InputCollectViewState();
}

class _InputCollectViewState extends State<InputCollectView>
    with AutomaticKeepAliveClientMixin {


      
  @override
  Widget build(BuildContext context) {
  
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InputView(
        inputType: InputType.collect,
        onSave: (money, category, note, date) {},
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
