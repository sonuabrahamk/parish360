import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/configurations/data/datasources/services_api.dart';
import 'package:parish360_mobile/features/configurations/data/repositories/service_repository_impl.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/service_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_providers.g.dart';

@riverpod
ServicesApi servicesApi(Ref ref) {
  return ServicesApi(ref.watch(dioProvider));
}

@riverpod
ServiceRepository serviceRepository(Ref ref) {
  return ServiceRepositoryImpl(ref.watch(servicesApiProvider));
}
