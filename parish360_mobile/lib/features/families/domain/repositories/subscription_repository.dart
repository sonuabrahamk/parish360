import 'package:parish360_mobile/features/families/domain/entities/subscription_info.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionInfo>> getSubscriptions(String familyId);
}
