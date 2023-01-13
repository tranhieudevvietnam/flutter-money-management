import 'package:money_management/domain/moneys/entities/money_model.dart';

class EventModel {
  final DateTime dateTime;
  final MoneyModel moneyModel;
  const EventModel(
      {required this.dateTime,
      required this.moneyModel});

  // @override
  // String toString() => "${moneyModel. + countPay}";
}
