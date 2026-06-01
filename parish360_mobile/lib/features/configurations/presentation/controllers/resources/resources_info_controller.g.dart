// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResourcesInfoController)
final resourcesInfoControllerProvider = ResourcesInfoControllerFamily._();

final class ResourcesInfoControllerProvider
    extends $AsyncNotifierProvider<ResourcesInfoController, ResourceInfo> {
  ResourcesInfoControllerProvider._({
    required ResourcesInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resourcesInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resourcesInfoControllerHash();

  @override
  String toString() {
    return r'resourcesInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ResourcesInfoController create() => ResourcesInfoController();

  @override
  bool operator ==(Object other) {
    return other is ResourcesInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resourcesInfoControllerHash() =>
    r'1d72841b1ccf79c5ec85cf0219d718b568db5dae';

final class ResourcesInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ResourcesInfoController,
          AsyncValue<ResourceInfo>,
          ResourceInfo,
          FutureOr<ResourceInfo>,
          String
        > {
  ResourcesInfoControllerFamily._()
    : super(
        retry: null,
        name: r'resourcesInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResourcesInfoControllerProvider call(String resourceId) =>
      ResourcesInfoControllerProvider._(argument: resourceId, from: this);

  @override
  String toString() => r'resourcesInfoControllerProvider';
}

abstract class _$ResourcesInfoController extends $AsyncNotifier<ResourceInfo> {
  late final _$args = ref.$arg as String;
  String get resourceId => _$args;

  FutureOr<ResourceInfo> build(String resourceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ResourceInfo>, ResourceInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ResourceInfo>, ResourceInfo>,
              AsyncValue<ResourceInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
