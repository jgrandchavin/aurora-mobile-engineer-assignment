// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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

  static Future<void> medium() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.medium();
    } catch (error, trace) {
      log.e('Failed to play medium haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> heavyImpact() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.heavy();
    } catch (error, trace) {
      log.e('Failed to play heavy haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> rigid() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.rigid();
    } catch (error, trace) {
      log.e('Failed to play rigid haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> soft() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.soft();
    } catch (error, trace) {
      log.e('Failed to play soft haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> success() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.success();
    } catch (error, trace) {
      log.e('Failed to play success haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> warning() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.warning();
    } catch (error, trace) {
      log.e('Failed to play warning haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> error() async {
    try {
      if (!hapticFeedbackEnabled) return;

      return Gaimon.error();
    } catch (error, trace) {
      log.e('Failed to play error haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> check() async {
    if (!hapticFeedbackEnabled) return;

    await Future<void>.delayed(const Duration(milliseconds: 400));
    await HapticFeedback.mediumImpact();

    await Future<void>.delayed(const Duration(milliseconds: 200));
    await HapticFeedback.mediumImpact();
  }

  static Future<void> bubbleAppear() async {
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

  static Future<void> bubbleAnimation() async {
    try {
      if (!hapticFeedbackEnabled) return;

      final haptic = {
        "Version": 1,
        "Pattern": [
          {
            "Event": {
              "Time": 0.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2}
              ]
            }
          },
          {
            "Event": {
              "Time": 2.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15}
              ]
            }
          },
          // Repeat pattern for full rotation
          {
            "Event": {
              "Time": 3.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2}
              ]
            }
          },
          {
            "Event": {
              "Time": 5.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15}
              ]
            }
          },
          // Second half of rotation
          {
            "Event": {
              "Time": 6.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2}
              ]
            }
          },
          {
            "Event": {
              "Time": 8.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15}
              ]
            }
          },
          // Final rotation segment
          {
            "Event": {
              "Time": 9.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2}
              ]
            }
          },
          {
            "Event": {
              "Time": 11.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15}
              ]
            }
          }
        ]
      };

      Gaimon.patternFromData(json.encode(haptic));
    } catch (error, trace) {
      log.e('Failed to play bubble animation haptic feedback',
          error: error, stackTrace: trace);
    }
  }

  static Future<void> bubbleFinale() async {
    try {
      if (!hapticFeedbackEnabled) return;

      final haptic = {
        "Version": 1,
        "Pattern": [
          {
            "Event": {
              "Time": 0.0,
              "EventType": "HapticContinuous",
              "EventDuration": 0.3,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.6},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.3}
              ]
            }
          },
          {
            "Event": {
              "Time": 0.3,
              "EventType": "HapticContinuous",
              "EventDuration": 0.5,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.8},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.5}
              ]
            }
          }
        ]
      };

      Gaimon.patternFromData(json.encode(haptic));
    } catch (error, trace) {
      log.e('Failed to play bubble finale haptic feedback',
          error: error, stackTrace: trace);
    }
  }
}
