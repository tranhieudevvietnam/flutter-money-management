import 'package:intl/intl.dart';

class FormatUtils {
  FormatUtils._();
  static FormatUtils get instant => FormatUtils._();
  

  moneyFormat({required num money}) {
    return "${NumberFormat("#,###", 'vi').format(money)} VNĐ";
  }

  numberFormat({required num money}) {
    return NumberFormat("#,###", 'vi').format(money);
  }
}
