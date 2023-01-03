import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DaysInMonthExtension on DateTime {
  int get daysInMonth {
    return DateTime(year, month + 1, 1)
        .difference(DateTime(year, month, 1))
        .inDays;
  }

  dateTimeConvertString({String? type}) {
    String formattedDate = DateFormat(
      type ?? "dd/MM/yyyy HH:mm",
    ).format(this);
    return formattedDate;
  }
}

class DateTimeUtils {
  DateTimeUtils._();
  static DateTimeUtils get instant => DateTimeUtils._();

  Future<DateTime?> datePicker(BuildContext context,
      {DateTime? dateTimeCurrent}) async {
    DateTime? dateResult = await showDatePicker(
        context: context,
        locale: const Locale("vi"),
        initialDate: dateTimeCurrent ?? DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    return dateResult;
  }

  Future<TimeOfDay?> timePicker(BuildContext context,
      {TimeOfDay? timeCurrent}) async {
    final timeResult = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return timeResult;
  }
}
