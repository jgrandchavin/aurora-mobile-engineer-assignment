import 'package:flutter/material.dart';

class ValueParser {
  static String parseString(dynamic value, {String defaultValue = ''}) {
    try {
      if (value is String) {
        return value;
      } else if (value is num) {
        return value.toString();
      } else if (defaultValue.isNotEmpty) {
        return defaultValue;
      } else {
        throw Exception('$value is not a parsable String');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static String? parseNullableString(dynamic value,
      {String defaultValue = ''}) {
    return value == null
        ? null
        : parseString(value, defaultValue: defaultValue);
  }

  static List<String> parseStringList(dynamic value,
      {List<String> defaultValue = const []}) {
    try {
      if (value is List) {
        return value.map(parseString).toList();
      } else {
        throw Exception('$value should be of type List');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static List<String>? parseNullableStringList(dynamic value,
      {List<String> defaultValue = const []}) {
    return value == null
        ? null
        : parseStringList(value, defaultValue: defaultValue);
  }

  static int parseInt(dynamic value,
      {int defaultValue = 0, bool mustBePositive = false}) {
    try {
      int result;

      if (value is int) {
        result = value.isNaN ? defaultValue : value;
      } else if (value is double) {
        result = value.isNaN ? defaultValue : value.toInt();
      } else if (value is String) {
        result = int.tryParse(value) ?? defaultValue;
      } else {
        throw Exception('$value should be of type int, double or String');
      }

      if (mustBePositive && result < 0) {
        throw Exception('$value must be positive');
      }

      return result;
    } catch (error) {
      return defaultValue;
    }
  }

  static int? parseNullableInt(dynamic value,
      {int defaultValue = 0, bool mustBePositive = false}) {
    return value == null
        ? null
        : parseInt(value,
            defaultValue: defaultValue, mustBePositive: mustBePositive);
  }

  static List<int> parseIntList(dynamic value,
      {List<int> defaultValue = const []}) {
    try {
      if (value is List) {
        return value.map<int>(parseInt).toList();
      } else {
        throw Exception('$value should be of type int');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static DateTime parseDateTime(dynamic value, {DateTime? defaultValue}) {
    try {
      if (value == null) return DateTime.now();
      if (value is Map && value['seconds'] != null) {
        return DateTime.fromMillisecondsSinceEpoch(value['seconds'] * 1000);
      } else if (value is DateTime) {
        return value;
      } else if (value is Map &&
          value['_seconds'] is int &&
          value['_nanoseconds'] is int) {
        return DateTime.fromMillisecondsSinceEpoch(value['_seconds'] * 1000);
      } else {
        throw Exception(
            '$value should be of type DateTime or Timestamp or Map');
      }
    } catch (error) {
      return defaultValue ?? DateTime.now();
    }
  }

  static DateTime? parseNullableDateTime(dynamic value,
      {DateTime? defaultValue}) {
    return value == null
        ? null
        : parseDateTime(value, defaultValue: defaultValue);
  }

  static double parseDouble(dynamic value, {double defaultValue = 0.0}) {
    try {
      if (value is double) {
        return value.isNaN ? defaultValue : value;
      } else if (value is int) {
        return value.isNaN ? defaultValue : value.toDouble();
      } else if (value is String) {
        return double.tryParse(value) ?? defaultValue;
      } else {
        throw Exception('$value should be of type int or double');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static double? parseNullableDouble(dynamic value,
      {double defaultValue = 0.0}) {
    return value == null
        ? null
        : parseDouble(value, defaultValue: defaultValue);
  }

  static List<double> parseDoubleList(dynamic value,
      {List<double> defaultValue = const []}) {
    try {
      if (value is List) {
        return value.map<double>(parseDouble).toList();
      } else {
        throw Exception('$value should be of type List');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    try {
      if (value is bool) {
        return value;
      } else if (value is int) {
        return value == 1;
      } else {
        throw Exception('$value should be of type bool or int');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static bool? parseNullableBool(dynamic value, {bool defaultValue = false}) {
    return value == null ? null : parseBool(value, defaultValue: defaultValue);
  }

  static Map<String, String> parseStringMap(
    dynamic value, {
    Map<String, String> defaultValue = const {},
  }) {
    try {
      if (value is Map) {
        return value.map((key, dynamic value) =>
            MapEntry<String, String>(key, ValueParser.parseString(value)));
      } else {
        throw Exception('$value should be of type Map');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static Map<String, List<String>> parseListStringMap(
    dynamic value, {
    Map<String, List<String>> defaultValue = const {},
  }) {
    try {
      if (value == null) {
        return defaultValue;
      } else if (value is Map) {
        return value.map((key, dynamic value) => MapEntry<String, List<String>>(
            key,
            ValueParser.parseList(value)
                .map(ValueParser.parseString)
                .toList()));
      } else {
        throw Exception('$value should be of type Map');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static List<dynamic> parseList(dynamic value,
      {List<dynamic> defaultValue = const []}) {
    try {
      if (value is List) {
        return value;
      } else {
        throw Exception('$value should be of type List');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static List<dynamic>? parseNullableList(dynamic value,
      {List<dynamic> defaultValue = const []}) {
    return value == null ? null : parseList(value, defaultValue: defaultValue);
  }

  static Color parseColorHex(dynamic value,
      {Color defaultValue = Colors.black}) {
    try {
      if (value is Color) {
        return value;
      } else if (value is String) {
        try {
          final hex = value.replaceAll('#', '').padLeft(8, 'f');
          return Color(int.parse(hex, radix: 16));
        } catch (_) {
          return defaultValue;
        }
      } else {
        throw Exception('$value should be of type Color');
      }
    } catch (error) {
      return defaultValue;
    }
  }

  static Color? parseNullableColorHex(dynamic value,
      {Color defaultValue = Colors.black}) {
    return value == null
        ? null
        : parseColorHex(value, defaultValue: defaultValue);
  }

  static int parseIntegerFromBool(bool value) => value ? 1 : 0;
}
