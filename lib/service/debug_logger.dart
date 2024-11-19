import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DebugLogger {
  static late final DebugLogger _instance;
  static bool _isInstanceCreated = false;
  final String className = "DebugLogger";

  final List<String> _apiLog = [];
  List<String> get apiLog => _apiLog;
  set apiLog(List<String> value) {
    _apiLog.addAll(value);
  }

  void addApiLog(String value) => _apiLog.add(value);

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  Future<void> debug(
      {required String className,
      String method = "main",
      required String value,
      bool printToConsole = true,
      bool captureException = false,
      dynamic throwable,
      dynamic stackTrace}) async {
    value =
        "At ${className.toString()} class - ${method.toString()} method - $value";
    value = "At ${DateTime.now()} - $value";
//    debugPrint(value);
    if (printToConsole) {
      logger.i(value);
      addApiLog(value);
    }
    if (captureException) {
      await Sentry.captureException(
        throwable,
        stackTrace: stackTrace,
      );
    }
  }

  static DebugLogger get instance {
    if (_isInstanceCreated == false) {
      _isInstanceCreated = true;
      _instance = DebugLogger._internal();
    }
    return _instance;
  }

  DebugLogger._internal() {
    debug(
      className: className,
      method: "DebugLogger._internal()",
      printToConsole: false,
      value: "Completed the DebugLogger instance",
    );
  }
}
