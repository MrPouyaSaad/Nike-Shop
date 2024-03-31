import 'package:intl/intl.dart';

extension PriceLable on int {
  String get withPriceLabel => NumberFormat.currency(
        decimalDigits: 0,
        customPattern: '000,000 تومان',
      ).format(this);
}
