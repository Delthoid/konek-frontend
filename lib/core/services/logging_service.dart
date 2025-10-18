import 'package:logger/logger.dart';

class LoggingService {
  final logger = Logger();

  void logInfo(String message) {
    logger.i(message);
  }

  void logWarning(String message) {
    logger.w(message);
  }

  void logError(String message) {
    logger.e(message);
  }
}