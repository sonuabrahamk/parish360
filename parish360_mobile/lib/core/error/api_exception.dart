import 'package:dio/dio.dart';

/// A lightweight application exception that wraps error details.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;

  /// Create an [ApiException] from a [DioException].
  ///
  /// Tries to extract a readable `message` from the response body
  /// when available, otherwise falls back to [DioException.message].
  static ApiException fromDio(DioException error) {
    try {
      final resp = error.response?.data;
      if (resp is Map<String, dynamic> && resp.containsKey('message')) {
        final msg =
            resp['message']?.toString() ?? error.message ?? 'Unknown error';
        return ApiException(msg, statusCode: error.response?.statusCode);
      }
    } catch (_) {
      // ignore parse errors
    }

    return ApiException(
      error.message ?? 'Request failed',
      statusCode: error.response?.statusCode,
    );
  }
}
