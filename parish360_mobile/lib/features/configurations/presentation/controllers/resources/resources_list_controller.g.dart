// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResourcesListController)
final resourcesListControllerProvider = ResourcesListControllerProvider._();

final class ResourcesListControllerProvider
    extends
        $AsyncNotifierProvider<ResourcesListController, List<ResourceInfo>> {
  ResourcesListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resourcesListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resourcesListControllerHash();

  @$internal
  @override
  ResourcesListController create() => ResourcesListController();
}

String _$resourcesListControllerHash() =>
    r'e1b1804d102dca071d7362c4879e0c5b94624c0e';

abstract class _$ResourcesListController
    extends $AsyncNotifier<List<ResourceInfo>> {
  FutureOr<List<ResourceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ResourceInfo>>, List<ResourceInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ResourceInfo>>, List<ResourceInfo>>,
              AsyncValue<List<ResourceInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
