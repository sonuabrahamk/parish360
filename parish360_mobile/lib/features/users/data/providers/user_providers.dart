import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/users/data/datasources/users_api.dart';
import 'package:parish360_mobile/features/users/data/repositories/users_repository_impl.dart';
import 'package:parish360_mobile/features/users/domain/repositories/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

@riverpod
UsersApi usersApi(Ref ref) {
  return UsersApi(ref.watch(dioProvider));
}

@riverpod
UsersRepository usersRepository(Ref ref) {
  return UsersRepositoryImpl(ref.watch(usersApiProvider));
}
