import 'package:flutter/material.dart';

class DateTimeUtils {
  DateTimeUtils._();
  static DateTimeUtils get instant => DateTimeUtils._();

  datePicker(BuildContext context) async {
    DateTime? dateResult = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    return dateResult;
  }

  timePicker(BuildContext context) async {
    final timeResult = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return timeResult;
  }
}
