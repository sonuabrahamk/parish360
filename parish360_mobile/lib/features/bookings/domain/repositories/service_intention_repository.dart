import 'package:parish360_mobile/features/bookings/domain/entities/service_intention_info.dart';

abstract class ServiceIntentionRepository {
  Future<List<ServiceIntentionInfo>> getServiceIntentions();
  Future<ServiceIntentionInfo> getServiceIntentionInfo(
    String serviceIntentionId,
  );
  Future<ServiceIntentionInfo> createServiceIntention(
    ServiceIntentionInfo serviceIntentionInfo,
  );
  Future<ServiceIntentionInfo> updateServiceIntention(
    String serviceIntentionId,
    ServiceIntentionInfo serviceIntentionInfo,
  );
  Future<void> deleteServiceIntention(String serviceIntentionId);
}
