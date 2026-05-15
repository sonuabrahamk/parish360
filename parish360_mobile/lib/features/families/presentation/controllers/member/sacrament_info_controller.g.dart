// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sacrament_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SacramentInfoController)
final sacramentInfoControllerProvider = SacramentInfoControllerFamily._();

final class SacramentInfoControllerProvider
    extends $AsyncNotifierProvider<SacramentInfoController, SacramentInfo?> {
  SacramentInfoControllerProvider._({
    required SacramentInfoControllerFamily super.from,
    required (String, String, String) super.argument,
  }) : super(
         retry: null,
         name: r'sacramentInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sacramentInfoControllerHash();

  @override
  String toString() {
    return r'sacramentInfoControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SacramentInfoController create() => SacramentInfoController();

  @override
  bool operator ==(Object other) {
    return other is SacramentInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sacramentInfoControllerHash() =>
    r'fda807bd3cb467bcd990e3567f20cb4973ad17c9';

final class SacramentInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SacramentInfoController,
          AsyncValue<SacramentInfo?>,
          SacramentInfo?,
          FutureOr<SacramentInfo?>,
          (String, String, String)
        > {
  SacramentInfoControllerFamily._()
    : super(
        retry: null,
        name: r'sacramentInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SacramentInfoControllerProvider call(
    String familyId,
    String memberId,
    String sacramentId,
  ) => SacramentInfoControllerProvider._(
    argument: (familyId, memberId, sacramentId),
    from: this,
  );

  @override
  String toString() => r'sacramentInfoControllerProvider';
}

abstract class _$SacramentInfoController
    extends $AsyncNotifier<SacramentInfo?> {
  late final _$args = ref.$arg as (String, String, String);
  String get familyId => _$args.$1;
  String get memberId => _$args.$2;
  String get sacramentId => _$args.$3;

  FutureOr<SacramentInfo?> build(
    String familyId,
    String memberId,
    String sacramentId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SacramentInfo?>, SacramentInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SacramentInfo?>, SacramentInfo?>,
              AsyncValue<SacramentInfo?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2, _$args.$3));
  }
}
