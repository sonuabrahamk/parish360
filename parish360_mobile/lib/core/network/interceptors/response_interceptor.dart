import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/auth_cleanup.dart';

class ResponseInterceptor extends Interceptor {
  final Ref ref;

  bool _isLoggingOut = false;

  ResponseInterceptor(this.ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401 && !_isLoggingOut) {
      _isLoggingOut = true;
      try {
        await performAuthCleanup(ref: ref);
      } catch (_) {
        // ignore cleanup errors
      }

      // Reject the request
      return handler.reject(err);
    }

    handler.next(err);
  }
}
