import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';

abstract class ResourceRepository {
  Future<List<ResourceInfo>> getAllResources();
  Future<ResourceInfo> getResourceInfo(String resourceId);
  Future<ResourceInfo> updateResourceInfo(
    String resourceId,
    ResourceInfo resourceInfo,
  );
  Future<ResourceInfo> createResource(ResourceInfo resourceInfo);
  Future<void> deleteResource(String resourceId);
}
