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
}
