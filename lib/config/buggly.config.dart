import 'package:flutter/foundation.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:xkd/utils/app_env.dart';
import 'package:xkd/utils/xkd_log.dart';

/// Bugly initialization helpers and constants.
class BuglyConfig {
  BuglyConfig._();

  static const String androidAppId = 'fe889b8c13';
  static const String androidAppKey = '13414baf-3deb-441d-bdbc-b2be543fab4f';

  static const String iosAppId = '1472c88a03';
  static const String iosAppKey = '1ba6e727-3cf7-4f85-b3be-cdaafc21706b';

  static const String channel = 'official';

  static Future<void> init() async {
    await FlutterBugly.init(
      androidAppId: androidAppId,
      iOSAppId: iosAppId,
      channel: channel,
    );
  }

  static Future<bool> handleException(
    Object error,
    StackTrace? stack,
  ) async {
    final isDebug = await isDebugMode();
    final stackTrace = stack ?? StackTrace.current;
    final message = error.toString();
    final detail = '$message\n$stackTrace';

    if (!isDebug && kReleaseMode) {
      await FlutterBugly.uploadException(
        type: error.runtimeType.toString(),
        message: message,
        detail: detail,
      );
    } else {
      showErrorAlert(message, stackTrace);
    }
    XKDLog.error(detail, error, stackTrace);
    return true;
  }
}

void showErrorAlert(String message, [StackTrace? stackTrace]) {
  FlutterError.dumpErrorToConsole(
    FlutterErrorDetails(
      exception: FlutterError(message),
      stack: stackTrace ?? StackTrace.current,
    ),
  );
  debugPrint('⚠️ $message');
}
