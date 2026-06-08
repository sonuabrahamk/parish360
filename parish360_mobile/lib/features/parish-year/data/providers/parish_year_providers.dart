import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/parish-year/data/datasources/parish_year_api.dart';
import 'package:parish360_mobile/features/parish-year/data/repositories/parish_year_repository_impl.dart';
import 'package:parish360_mobile/features/parish-year/domain/repositories/parish_year_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parish_year_providers.g.dart';

@riverpod
ParishYearApi parishYearApi(Ref ref) {
  return ParishYearApi(ref.watch(dioProvider));
}

@riverpod
ParishYearRepository parishYearRepository(Ref ref) {
  return ParishYearRepositoryImpl(ref.watch(parishYearApiProvider));
}
