import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:parish360_mobile/core/config/environment_configuration.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cookie_jar_provider.dart';

part 'auth_dio_provider.g.dart';

@riverpod
Dio authDio(Ref ref) {
  final env = EnvironmentConfiguration.instance;
  final authDio = Dio(
    BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  authDio.interceptors.addAll([
    CookieManager(ref.watch(cookieJarProvider)),
  ]);

  if (env.enableLogs) {
    authDio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  return authDio;
}
