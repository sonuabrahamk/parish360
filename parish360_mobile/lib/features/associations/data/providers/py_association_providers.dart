import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/associations/data/datasources/py_associations_api.dart';
import 'package:parish360_mobile/features/associations/data/repositories/py_association_repository_impl.dart';
import 'package:parish360_mobile/features/associations/domain/repositories/py_association_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'py_association_providers.g.dart';

@riverpod
PyAssociationsApi pyAssociationsApi(Ref ref) {
  return PyAssociationsApi(ref.watch(dioProvider));
}

@riverpod
PyAssociationRepository pyAssociationRepository(Ref ref) {
  return PyAssociationRepositoryImpl(ref.watch(pyAssociationsApiProvider));
}
