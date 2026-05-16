import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/migration_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/migration_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/migration_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'migration_providers.g.dart';

@riverpod
MigrationApi migrationApi(Ref ref) {
  return MigrationApi(ref.watch(dioProvider));
}

@riverpod
MigrationRepository migrationRepository(Ref ref) {
  return MigrationRepositoryImpl(ref.watch(migrationApiProvider));
}