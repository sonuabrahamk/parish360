// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sacrament_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SacramentListController)
final sacramentListControllerProvider = SacramentListControllerFamily._();

final class SacramentListControllerProvider
    extends
        $AsyncNotifierProvider<SacramentListController, List<SacramentInfo>> {
  SacramentListControllerProvider._({
    required SacramentListControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'sacramentListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sacramentListControllerHash();

  @override
  String toString() {
    return r'sacramentListControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SacramentListController create() => SacramentListController();

  @override
  bool operator ==(Object other) {
    return other is SacramentListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sacramentListControllerHash() =>
    r'ce10417fd7da1580de98398fb0769fcf01fe0e53';

final class SacramentListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SacramentListController,
          AsyncValue<List<SacramentInfo>>,
          List<SacramentInfo>,
          FutureOr<List<SacramentInfo>>,
          (String, String)
        > {
  SacramentListControllerFamily._()
    : super(
        retry: null,
        name: r'sacramentListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SacramentListControllerProvider call(String familyId, String memberId) =>
      SacramentListControllerProvider._(
        argument: (familyId, memberId),
        from: this,
      );

  @override
  String toString() => r'sacramentListControllerProvider';
}

abstract class _$SacramentListController
    extends $AsyncNotifier<List<SacramentInfo>> {
  late final _$args = ref.$arg as (String, String);
  String get familyId => _$args.$1;
  String get memberId => _$args.$2;

  FutureOr<List<SacramentInfo>> build(String familyId, String memberId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SacramentInfo>>, List<SacramentInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SacramentInfo>>, List<SacramentInfo>>,
              AsyncValue<List<SacramentInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
