import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/auth/data/providers/auth_providers.dart';

class ParishInterceptor extends Interceptor {
  final Ref ref;

  ParishInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.path = options.path.replaceAll(
      '{parishId}',
      ref.watch(parishProvider),
    );

    handler.next(options);
  }
}
