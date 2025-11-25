// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:io';

import 'package:gaimon/gaimon.dart';

import 'logger.dart';

// ⚠️ Haptic feedback can cause lags on Android phones.
// Therefore, they need to be deactivated by default on Android
class HapticFeedbackUtils {
  static bool get hapticFeedbackEnabled => Platform.isIOS;

  static Future<void> selection() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.selection();
    } catch (error, trace) {
      log.e('Failed to play selection haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> light() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.light();
    } catch (error, trace) {
      log.e('Failed to play light haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> imageAppear() async {
    try {
      if (!hapticFeedbackEnabled) return;

      final haptic = {
        "Version": 1,
        "Pattern": [
          {
            "Event": {
              "Time": 0.0,
              "EventType": "HapticContinuous",
              "EventDuration": 0.4,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.4},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.3}
              ]
            }
          },
          {
            "Event": {
              "Time": 0.4,
              "EventType": "HapticContinuous",
              "EventDuration": 0.4,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.2},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15}
              ]
            }
          }
        ]
      };

      // Play pattern synced with bubble appearance animation (800ms)
      Gaimon.patternFromData(json.encode(haptic));
    } catch (error, trace) {
      log.e('Failed to play bubble appear haptic feedback',
          error: error, stackTrace: trace);
    }
  }
}
