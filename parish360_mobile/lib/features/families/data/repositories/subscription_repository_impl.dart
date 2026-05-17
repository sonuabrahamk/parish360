import 'package:parish360_mobile/features/families/data/datasources/subscriptions_api.dart';
import 'package:parish360_mobile/features/families/domain/entities/subscription_info.dart';
import 'package:parish360_mobile/features/families/domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionsApi api;

  SubscriptionRepositoryImpl(this.api);

  @override
  Future<List<SubscriptionInfo>> getSubscriptions(String familyId) {
    return api.getSubscriptions(familyId);
  }
}
