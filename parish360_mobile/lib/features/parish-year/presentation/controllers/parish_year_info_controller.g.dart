// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish_year_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParishYearInfoController)
final parishYearInfoControllerProvider = ParishYearInfoControllerFamily._();

final class ParishYearInfoControllerProvider
    extends $AsyncNotifierProvider<ParishYearInfoController, ParishYearInfo> {
  ParishYearInfoControllerProvider._({
    required ParishYearInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'parishYearInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$parishYearInfoControllerHash();

  @override
  String toString() {
    return r'parishYearInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ParishYearInfoController create() => ParishYearInfoController();

  @override
  bool operator ==(Object other) {
    return other is ParishYearInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$parishYearInfoControllerHash() =>
    r'38e3fdbac5dc441483373ee786c4cea4ef6e2b8f';

final class ParishYearInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ParishYearInfoController,
          AsyncValue<ParishYearInfo>,
          ParishYearInfo,
          FutureOr<ParishYearInfo>,
          String
        > {
  ParishYearInfoControllerFamily._()
    : super(
        retry: null,
        name: r'parishYearInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ParishYearInfoControllerProvider call(String parishYearId) =>
      ParishYearInfoControllerProvider._(argument: parishYearId, from: this);

  @override
  String toString() => r'parishYearInfoControllerProvider';
}

abstract class _$ParishYearInfoController
    extends $AsyncNotifier<ParishYearInfo> {
  late final _$args = ref.$arg as String;
  String get parishYearId => _$args;

  FutureOr<ParishYearInfo> build(String parishYearId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ParishYearInfo>, ParishYearInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ParishYearInfo>, ParishYearInfo>,
              AsyncValue<ParishYearInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
