import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/core/config/environment_configuration.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cookie_jar_provider.dart';

part 'auth_dio_provider.g.dart';

@riverpod
Dio authDio(Ref ref) {
  final env = EnvironmentConfiguration.instance;
  final dio = Dio(
    BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.addAll([
    CookieManager(ref.watch(cookieJarProvider)),
  ]);

  if (env.enableLogs) {
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        ref.read(authControllerProvider.notifier).logout();
        AppNavigator.popAllAndPush('/login');
      }
      handler.next(error);
    },
  ));

  return dio;
}
