import 'package:parish360_mobile/core/network/auth_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../datasources/auth_api.dart';
import '../repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(authDioProvider));
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authApiProvider));
}
