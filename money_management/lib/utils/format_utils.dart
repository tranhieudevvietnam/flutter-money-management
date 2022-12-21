import 'package:intl/intl.dart';

class FormatUtils {
  FormatUtils._();
  static FormatUtils get instant => FormatUtils._();
  dateTimeConvertString({required DateTime date, String? type}) {
    String formattedDate = DateFormat(type ?? "dd/MM/yyyy HH:mm").format(date);
    return formattedDate;
  }
}
