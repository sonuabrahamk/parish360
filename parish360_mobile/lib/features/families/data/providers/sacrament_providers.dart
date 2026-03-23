import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/sacrament_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/sacrament_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/sacrament_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sacrament_providers.g.dart';

@riverpod
SacramentApi sacramentApi(Ref ref) {
  return SacramentApi(ref.watch(dioProvider));
}

@riverpod
SacramentRepository sacramentRepository(Ref ref) {
  return SacramentRepositoryImpl(ref.watch(sacramentApiProvider));
}