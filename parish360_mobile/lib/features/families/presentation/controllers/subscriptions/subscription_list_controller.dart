import 'package:parish360_mobile/features/families/data/providers/subscriptions_providers.dart';
import 'package:parish360_mobile/features/families/domain/entities/subscription_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_list_controller.g.dart';

@riverpod
class SubscriptionListController extends _$SubscriptionListController {
  @override
  Future<List<SubscriptionInfo>> build(String familyId) async {
    return ref.read(subscriptionRepositoryProvider).getSubscriptions(familyId);
  }
}
