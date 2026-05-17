import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/blessings_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/blessing_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/blessing_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blessings_providers.g.dart';

@riverpod
BlessingsApi blessingsApi(Ref ref) {
  return BlessingsApi(ref.watch(dioProvider));
}

@riverpod
BlessingRepository blessingRepository(Ref ref) {
  return BlessingRepositoryImpl(ref.watch(blessingsApiProvider));
}
