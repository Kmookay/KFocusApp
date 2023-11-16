import 'package:logger/logger.dart';

class KLogger {
  static final logger = Logger();
  static const _isDebug = true;

  static void d(String message) {
    if (!_isDebug) return;
    logger.d(message);
  }

  static void e(String message) {
    if (!_isDebug) return;
    logger.e(message);
  }
}
