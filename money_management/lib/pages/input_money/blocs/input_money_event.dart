part of 'input_money_bloc.dart';

@immutable
abstract class InputMoneyEvent {}

class InputInsertEvent extends InputMoneyEvent {
  final CategoryModel categoryModel;
  final String note;
  final DateTime dateTime;
  final num money;
  final MoneyType type;

  InputInsertEvent(
      {required this.categoryModel,
      required this.note,
      required this.dateTime,
      required this.type,
      required this.money});
}
