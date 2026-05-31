import 'package:parish360_mobile/features/configurations/data/datasources/services_api.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/service_info.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServicesApi _servicesApi;

  ServiceRepositoryImpl(this._servicesApi);

  @override
  Future<ServiceInfo> createService(ServiceInfo serviceInfo) async {
    return await _servicesApi.createService(serviceInfo);
  }

  @override
  Future<void> deleteService(String serviceId) async {
    return await _servicesApi.deleteService(serviceId);
  }

  @override
  Future<List<ServiceInfo>> getAllServices() async {
    return await _servicesApi.getAllServices();
  }

  @override
  Future<ServiceInfo> getServiceInfo(String serviceId) async {
    return await _servicesApi.getServiceInfo(serviceId);
  }
}
