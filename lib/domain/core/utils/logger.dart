import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final log = Logger(
  filter: _DebugLogFilter(),
);

class _DebugLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}
