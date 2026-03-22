// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_info_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyInfoListController)
final familyInfoListControllerProvider = FamilyInfoListControllerProvider._();

final class FamilyInfoListControllerProvider
    extends $AsyncNotifierProvider<FamilyInfoListController, List<FamilyInfo>> {
  FamilyInfoListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyInfoListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyInfoListControllerHash();

  @$internal
  @override
  FamilyInfoListController create() => FamilyInfoListController();
}

String _$familyInfoListControllerHash() =>
    r'adb2e30c766b4b912e896979492a83d4d5acff61';

abstract class _$FamilyInfoListController
    extends $AsyncNotifier<List<FamilyInfo>> {
  FutureOr<List<FamilyInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FamilyInfo>>, List<FamilyInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FamilyInfo>>, List<FamilyInfo>>,
              AsyncValue<List<FamilyInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
