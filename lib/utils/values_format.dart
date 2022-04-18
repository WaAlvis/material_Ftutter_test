import 'package:intl/intl.dart';

class ValueCurrencyFormat {
  static String format(double value, {bool isUsd = false}) {
    final NumberFormat currency = NumberFormat.currency(
      locale: 'eu',
      symbol: '',
      decimalDigits: isUsd
          ? value != 0
              ? 2
              : 0
          : 0,
      customPattern: '#,###',
    );
    if (isUsd) {
      return '${(value - 1) < 0 ? 0 : ""}${currency.format(value)}';
    }
    return '${(value - 1) < -1 ? 0 : ""}${currency.format(value)}';
  }
}
