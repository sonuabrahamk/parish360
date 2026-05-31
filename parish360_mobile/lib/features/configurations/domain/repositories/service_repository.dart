import 'package:parish360_mobile/features/configurations/domain/entities/service_info.dart';

abstract class ServiceRepository {
  Future<List<ServiceInfo>> getAllServices();
  Future<ServiceInfo> getServiceInfo(String serviceId);
  Future<ServiceInfo> createService(ServiceInfo serviceInfo);
  Future<void> deleteService(String serviceId);
}
