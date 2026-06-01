import 'package:parish360_mobile/features/configurations/data/providers/resources_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resources_list_controller.g.dart';

@riverpod
class ResourcesListController extends _$ResourcesListController {
  @override
  Future<List<ResourceInfo>> build() async {
    return await ref.read(resourceRepositoryProvider).getAllResources();
  }
}