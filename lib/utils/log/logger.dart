import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

/// print full log
class LogUtil {
  // Sample of abstract logging function
  static void debug(dynamic text, {bool isError = false}) {
    if (isError) {
      logger.d('** $text, isError [$isError]');
    } else {
      logger.d('** $text');
    }
  }

  static void print(dynamic text, {bool isError = false}) {
    if (isError) {
      logger.d('** $text, isError [$isError]');
    } else {
      logger.d('** $text');
    }
  }

  static void warn(dynamic text, {bool isError = false}) {
    if (isError) {
      logger.w('** $text, isError [$isError]');
    } else {
      logger.w('** $text');
    }
  }
}
