import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/configurations/data/datasources/associations_api.dart';
import 'package:parish360_mobile/features/configurations/data/repositories/association_repository_impl.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/association_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'associations_providers.g.dart';

@riverpod
AssociationsApi associationsApi(Ref ref) {
  return AssociationsApi(ref.watch(dioProvider));
}

@riverpod
AssociationRepository associationRepository(Ref ref) {
  return AssociationRepositoryImpl(ref.watch(associationsApiProvider));
}
