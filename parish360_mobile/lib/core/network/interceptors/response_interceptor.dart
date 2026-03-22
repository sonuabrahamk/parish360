import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

class ResponseInterceptor extends Interceptor {
  final Ref ref;

  bool _isLoggingOut = false;

  ResponseInterceptor(this.ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401 && !_isLoggingOut) {
      _isLoggingOut = true;

      // 🔹 Clear auth + providers
      await ref.read(authControllerProvider.notifier).logout();

      // 🔹 Global navigation (no context)
      AppNavigator.popAllAndPush('/login');

      // 🔹 Reject the request
      return handler.reject(err);
    }

    handler.next(err);
  }
}