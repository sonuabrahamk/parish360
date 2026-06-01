import 'package:parish360_mobile/features/configurations/data/providers/resources_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resources_info_controller.g.dart';

@riverpod
class ResourcesInfoController extends _$ResourcesInfoController {
  @override
  Future<ResourceInfo> build(String resourceId) async {
    return await ref
        .read(resourceRepositoryProvider)
        .getResourceInfo(resourceId);
  }

  Future<ResourceInfo> createResourceInfo(ResourceInfo resourceInfo) async {
    final newResource = await ref
        .read(resourceRepositoryProvider)
        .createResource(resourceInfo);
    if (!ref.mounted) {
      return newResource;
    }
    state = AsyncValue.data(newResource);
    return newResource;
  }

  Future<ResourceInfo> updateResourceInfo(
    String resourceId,
    ResourceInfo resourceInfo,
  ) async {
    final updatedResource = await ref
        .read(resourceRepositoryProvider)
        .updateResourceInfo(resourceId, resourceInfo);
    if (!ref.mounted) {
      return updatedResource;
    }
    state = AsyncValue.data(updatedResource);
    return updatedResource;
  }

  Future<void> deleteResourceInfo(String resourceId) async {
    await ref.read(resourceRepositoryProvider).deleteResource(resourceId);
  }
}
