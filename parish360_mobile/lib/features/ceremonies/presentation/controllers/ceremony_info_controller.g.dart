// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremony_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CeremonyInfoController)
final ceremonyInfoControllerProvider = CeremonyInfoControllerFamily._();

final class CeremonyInfoControllerProvider
    extends $AsyncNotifierProvider<CeremonyInfoController, CeremonyInfo> {
  CeremonyInfoControllerProvider._({
    required CeremonyInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ceremonyInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ceremonyInfoControllerHash();

  @override
  String toString() {
    return r'ceremonyInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CeremonyInfoController create() => CeremonyInfoController();

  @override
  bool operator ==(Object other) {
    return other is CeremonyInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ceremonyInfoControllerHash() =>
    r'4abb8d0b801de032bf4a49d5520cc5a60e6a31eb';

final class CeremonyInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CeremonyInfoController,
          AsyncValue<CeremonyInfo>,
          CeremonyInfo,
          FutureOr<CeremonyInfo>,
          String
        > {
  CeremonyInfoControllerFamily._()
    : super(
        retry: null,
        name: r'ceremonyInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CeremonyInfoControllerProvider call(String ceremonyId) =>
      CeremonyInfoControllerProvider._(argument: ceremonyId, from: this);

  @override
  String toString() => r'ceremonyInfoControllerProvider';
}

abstract class _$CeremonyInfoController extends $AsyncNotifier<CeremonyInfo> {
  late final _$args = ref.$arg as String;
  String get ceremonyId => _$args;

  FutureOr<CeremonyInfo> build(String ceremonyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CeremonyInfo>, CeremonyInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CeremonyInfo>, CeremonyInfo>,
              AsyncValue<CeremonyInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
