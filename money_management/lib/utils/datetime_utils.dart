import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/hives/hive_constant.dart';
import 'package:money_management/hives/hive_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final local = HiveUtil.boxLocal.get(HiveKeyConstant.language);
    DateTime? dateResult = await showDatePicker(
        context: context,
        locale: Locale(local),
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
      helpText:
          "${AppLocalizations.of(context)!.select} ${AppLocalizations.of(context)!.time}"
              .toUpperCase(),
      cancelText: AppLocalizations.of(context)!.close,
      confirmText: AppLocalizations.of(context)!.continueText,
      initialTime: TimeOfDay.now(),
    );
    return timeResult;
  }
}
