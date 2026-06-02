import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/bookings/data/datasources/service_intentions_api.dart';
import 'package:parish360_mobile/features/bookings/data/repositories/service_intention_repository_impl.dart';
import 'package:parish360_mobile/features/bookings/domain/repositories/service_intention_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_intention_providers.g.dart';

@riverpod
ServiceIntentionsApi serviceIntentionsApi(Ref ref) {
  return ServiceIntentionsApi(ref.watch(dioProvider));
}

@riverpod
ServiceIntentionRepository serviceIntentionRepository(Ref ref) {
  return ServiceIntentionRepositoryImpl(
    ref.watch(serviceIntentionsApiProvider),
  );
}
