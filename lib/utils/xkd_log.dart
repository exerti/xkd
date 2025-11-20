import 'package:logger/logger.dart';

class XKDLog {
  XKDLog._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTime,
      levelColors: {
        Level.trace: const AnsiColor.none(),
        Level.debug: const AnsiColor.fg(8), // gray
        Level.info: const AnsiColor.fg(2), // green
        Level.warning: const AnsiColor.fg(3), // yellow
        Level.error: const AnsiColor.fg(1), // red
        Level.fatal: const AnsiColor.fg(5), // magenta
      },
    ),
  );

  static void info(String message) {
    _logger.i(message);
  }

  static void warn(String message) {
    _logger.w(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
