import 'value_parser.dart';

class ServerException implements Exception {
  const ServerException({
    required this.code,
    required this.endpoint,
    required this.error,
    required this.message,
  });

  factory ServerException.fromJson(
      {required Map<String, dynamic>? json, required String endpoint}) {
    json ??= {};
    return ServerException(
      endpoint: endpoint,
      code: ValueParser.parseString(json['statusCode'] ?? 'UNKNOWN_ERROR'),
      error: ValueParser.parseString(json['error'] ?? 'Internal server error'),
      message:
          ValueParser.parseString(json['message'] ?? 'Internal server error'),
    );
  }

  final String code;
  final String endpoint;
  final String error;
  final String message;

  @override
  String toString() => 'ServerException([$code] $endpoint - $error - $message)';
}
