import 'dart:math';

import 'package:decimal/decimal.dart';

class StringUtils {
  StringUtils._();

  static String truncateString(String input, {int maxLength = 32}) {
    const middle = '...';
    if (input.length <= maxLength) {
      return input;
    } else {
      int halfLength = (maxLength - middle.length) ~/ 2;
      return input.substring(0, halfLength) +
          middle +
          input.substring(input.length - halfLength);
    }
  }

  static double toDotDouble(String input) {
    BigInt decimalBalance =
        BigInt.parse(input.toString().replaceFirst('0x', ''), radix: 16);

    final balance = decimalBalance / BigInt.from(10).pow(12);
    return balance;
  }
}

extension HexToDotBalance on String {
  double toDotBalance() {
    return StringUtils.toDotDouble(this);
  }
}
