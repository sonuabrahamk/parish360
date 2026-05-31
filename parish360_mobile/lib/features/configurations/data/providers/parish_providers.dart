import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/configurations/data/datasources/parish_api.dart';
import 'package:parish360_mobile/features/configurations/data/repositories/parish_repository_impl.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/parish_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parish_providers.g.dart';

@riverpod
ParishApi parishApi(Ref ref) {
  return ParishApi(ref.watch(dioProvider));
}

@riverpod
ParishRepository parishRepository(Ref ref) {
  return ParishRepositoryImpl(ref.watch(parishApiProvider));
}
