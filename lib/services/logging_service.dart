import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

enum LogLevel { info, error, off }

@lazySingleton
class LoggingService {
  final GetIt getIt = GetIt.instance;
  String logLevel = dotenv.env['LOG_LEVEL'].toString();
  final log = Logger('LoggingService');

  logMessage(Object message, context, {bool showToast = true}) async {
    if (showToast) {
      final snack = SnackBar(
          content: Text(message.toString(),
              style: const TextStyle(color: Colors.green)));
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    log.info(message);
  }

  logError(Object error, StackTrace stackTrace, context,
      {bool showToast = true}) async {
    if (logLevel == LogLevel.off.toString()) {
      return;
    }
    if (showToast && context != null) {
      final snack = SnackBar(
          content: Text(error.toString(),
              style: const TextStyle(color: Colors.red)));
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    log.severe(error, stackTrace);
  }
}
