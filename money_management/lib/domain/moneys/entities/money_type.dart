import 'package:hive/hive.dart';

part 'money_type.g.dart';

@HiveType(typeId: 3)
enum MoneyType {
  @HiveField(0,defaultValue: true)
  pay,
  @HiveField(1)
  collect,
}