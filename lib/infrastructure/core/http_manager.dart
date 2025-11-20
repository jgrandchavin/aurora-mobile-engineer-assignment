import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../domain/core/utils/exceptions.dart';
import '../../domain/core/utils/logger.dart';

class HttpManager extends GetxService {
  final http.Client httpClient;
  String serverUrl;

  HttpManager({
    required this.httpClient,
    required this.serverUrl,
  });

  Future<Map<String, String>> _getHeaders() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  Uri _parseEndpointUri(String endpoint) => Uri.parse('$serverUrl/$endpoint');

  Map<String, dynamic> _handleResponse(
      http.Response response, String endpoint) {
    if (response.statusCode == 200) {
      log.i('[Http] <- $endpoint [200] ${response.body}');
      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } else if (response.statusCode == 409) {
      log.i('[Http] <- $endpoint [409] ${response.body}');
      final json =
          response.headers['content-type']?.contains('application/json') == true
              ? jsonDecode(response.body)
              : {'error': response.body};
      return {
        'statusCode': response.statusCode,
        'body': json,
      };
    } else if (response.statusCode == 500) {
      final json =
          response.headers['content-type']?.contains('application/json') == true
              ? jsonDecode(response.body)
              : {'error': response.body};
      log.e('[Http] <- ServerException $endpoint $json');
      throw ServerException.fromJson(json: json, endpoint: endpoint);
    } else {
      log.e('[Http] <- $endpoint [${response.statusCode}] ${response.body}');
      throw ServerException(
          code: response.statusCode.toString(),
          endpoint: endpoint,
          error: 'UNKNOWN',
          message: response.body);
    }
  }

  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? queryParameters,
  }) async {
    Uri uri;
    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = Uri.parse('$serverUrl/$endpoint')
          .replace(queryParameters: queryParameters);
    } else {
      uri = _parseEndpointUri(endpoint);
    }
    final headers = await _getHeaders();
    log.i('[Http] -> $endpoint GET params=$queryParameters');
    final response = await httpClient.get(uri, headers: headers);
    return _handleResponse(response, endpoint);
  }

  Future<dynamic> postRequest({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    body ??= {};
    final uri = _parseEndpointUri(endpoint);
    final headers = await _getHeaders();
    log.i('[Http] -> $endpoint body=$body');
    final response =
        await httpClient.post(uri, headers: headers, body: json.encode(body));
    return _handleResponse(response, endpoint);
  }

  Future<dynamic> postRequestWithAudio({
    required String endpoint,
    required File audioFile,
  }) async {
    final uri = _parseEndpointUri(endpoint);
    final headers = await _getHeaders();

    // Read audio file bytes
    final bytes = await audioFile.readAsBytes();

    // Create multipart request
    final request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll(headers);

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        'audio',
        bytes,
        filename: 'audio.m4a',
      ),
    );

    log.i('[Http] -> $endpoint with audio (size: ${bytes.length} bytes)');

    // Send request and get response
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response, endpoint);
  }
}
