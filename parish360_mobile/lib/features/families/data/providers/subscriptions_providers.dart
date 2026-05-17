import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/subscriptions_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/subscription_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/subscription_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscriptions_providers.g.dart';

@riverpod
SubscriptionsApi subscriptionsApi(Ref ref) {
  return SubscriptionsApi(ref.watch(dioProvider));
}

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) {
  return SubscriptionRepositoryImpl(ref.watch(subscriptionsApiProvider));
}
