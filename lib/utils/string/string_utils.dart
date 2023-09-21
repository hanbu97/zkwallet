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

  static String toDotDoubleStr(String input, {precision = 3}) {
    final d = toDotDouble(input);
    return d.toStringAsFixed(precision);
  }

  static double toDotDouble(String input) {
    BigInt decimalBalance =
        BigInt.parse(input.toString().replaceFirst('0x', ''), radix: 16);

    final balance = decimalBalance / BigInt.from(10).pow(12);
    return balance;
  }

  static double toDouble(String input) {
    BigInt decimalBalance = BigInt.parse(input.toString());
    final balance = decimalBalance / BigInt.from(10).pow(12);
    return balance;
  }

  static String toDotBigIntStr(String input) {
    BigInt decimalBalance = BigInt.parse(input.toString());
    final balance = decimalBalance * BigInt.from(10).pow(12);
    return balance.toString();
  }
}

extension HexToDotBalance on String {
  String toBigIntStr() {
    return StringUtils.toDotBigIntStr(this);
  }

  double toDotBalance() {
    return StringUtils.toDotDouble(this);
  }

  double toBalance() {
    return StringUtils.toDouble(this);
  }
}
