import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/ceremonies/data/datasources/ceremonies_api.dart';
import 'package:parish360_mobile/features/ceremonies/data/repositories/ceremonies_repository_impl.dart';
import 'package:parish360_mobile/features/ceremonies/domain/repositories/ceremonies_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ceremony_providers.g.dart';

@riverpod
CeremoniesApi ceremoniesApi(Ref ref) {
  return CeremoniesApi(ref.watch(dioProvider));
}

@riverpod
CeremoniesRepository ceremoniesRepository(Ref ref) {
  return CeremoniesRepositoryImpl(ref.watch(ceremoniesApiProvider));
}
