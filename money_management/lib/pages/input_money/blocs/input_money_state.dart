part of 'input_money_bloc.dart';

@immutable
abstract class InputMoneyState {}

class InputMoneyInitial extends InputMoneyState {
  final String? message;

  InputMoneyInitial({this.message});
}


class InputInsertSuccess extends InputMoneyInitial{
  InputInsertSuccess({super.message});
}
class InputInsertFailure extends InputMoneyInitial{
  InputInsertFailure({super.message});
}
