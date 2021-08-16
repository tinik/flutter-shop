import 'package:intl/intl.dart';

format(dynamic value) {
  final currency = new NumberFormat("#,##0.00", "en_US");
  return currency.format(value);
}