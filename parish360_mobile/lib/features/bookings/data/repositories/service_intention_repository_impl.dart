import 'package:parish360_mobile/features/bookings/data/datasources/service_intentions_api.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/service_intention_info.dart';
import 'package:parish360_mobile/features/bookings/domain/repositories/service_intention_repository.dart';

class ServiceIntentionRepositoryImpl implements ServiceIntentionRepository {
  final ServiceIntentionsApi _serviceIntentionsApi;

  ServiceIntentionRepositoryImpl(this._serviceIntentionsApi);

  @override
  Future<ServiceIntentionInfo> createServiceIntention(
    ServiceIntentionInfo serviceIntentionInfo,
  ) async {
    return await _serviceIntentionsApi.createServiceIntention(
      serviceIntentionInfo,
    );
  }

  @override
  Future<void> deleteServiceIntention(String serviceIntentionId) async {
    return await _serviceIntentionsApi.deleteServiceIntention(
      serviceIntentionId,
    );
  }

  @override
  Future<ServiceIntentionInfo> getServiceIntentionInfo(
    String serviceIntentionId,
  ) async {
    return await _serviceIntentionsApi.getServiceIntentionInfo(
      serviceIntentionId,
    );
  }

  @override
  Future<List<ServiceIntentionInfo>> getServiceIntentions() async {
    return await _serviceIntentionsApi.getServiceIntentions();
  }

  @override
  Future<ServiceIntentionInfo> updateServiceIntention(
    String serviceIntentionId,
    ServiceIntentionInfo serviceIntentionInfo,
  ) async {
    return await _serviceIntentionsApi.updateServiceIntention(
      serviceIntentionId,
      serviceIntentionInfo,
    );
  }
}
