import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/configurations/data/datasources/resources_api.dart';
import 'package:parish360_mobile/features/configurations/data/repositories/resource_repository_impl.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/resource_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resources_providers.g.dart';

@riverpod
ResourcesApi resourcesApi(Ref ref) {
  return ResourcesApi(ref.watch(dioProvider));
}

@riverpod
ResourceRepository resourceRepository(Ref ref) {
  return ResourceRepositoryImpl(ref.watch(resourcesApiProvider));
}
