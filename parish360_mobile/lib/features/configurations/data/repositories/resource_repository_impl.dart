import 'package:parish360_mobile/features/configurations/data/datasources/resources_api.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/resource_repository.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourcesApi _resourcesApi;

  ResourceRepositoryImpl(this._resourcesApi);

  @override
  Future<ResourceInfo> createResource(ResourceInfo resourceInfo) async {
    return await _resourcesApi.createResource(resourceInfo);
  }

  @override
  Future<void> deleteResource(String resourceId) async {
    return await _resourcesApi.deleteResource(resourceId);
  }

  @override
  Future<List<ResourceInfo>> getAllResources() async {
    return await _resourcesApi.getAllResources();
  }

  @override
  Future<ResourceInfo> getResourceInfo(String resourceId) async {
    return await _resourcesApi.getResourceInfo(resourceId);
  }

  @override
  Future<ResourceInfo> updateResourceInfo(
    String resourceId,
    ResourceInfo resourceInfo,
  ) async {
    return await _resourcesApi.updateResource(resourceId, resourceInfo);
  }
}
