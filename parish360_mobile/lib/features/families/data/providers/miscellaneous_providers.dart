import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/miscellaneous_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/micellaneous_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/miscellaneous_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'miscellaneous_providers.g.dart';

@riverpod
MiscellaneousApi miscellaneousApi(Ref ref) {
  return MiscellaneousApi(ref.watch(dioProvider));
}

@riverpod
MiscellaneousRepository miscellaneousRepository(Ref ref) {
  return MiscellaneousRepositoryImpl(ref.watch(miscellaneousApiProvider));
}
