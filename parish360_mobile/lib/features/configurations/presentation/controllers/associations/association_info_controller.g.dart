// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssociationInfoController)
final associationInfoControllerProvider = AssociationInfoControllerFamily._();

final class AssociationInfoControllerProvider
    extends $AsyncNotifierProvider<AssociationInfoController, AssociationInfo> {
  AssociationInfoControllerProvider._({
    required AssociationInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'associationInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$associationInfoControllerHash();

  @override
  String toString() {
    return r'associationInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AssociationInfoController create() => AssociationInfoController();

  @override
  bool operator ==(Object other) {
    return other is AssociationInfoControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$associationInfoControllerHash() =>
    r'dfe876e1abbe6dc4e27ed68b8e176bc9c0ef3b5f';

final class AssociationInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AssociationInfoController,
          AsyncValue<AssociationInfo>,
          AssociationInfo,
          FutureOr<AssociationInfo>,
          String
        > {
  AssociationInfoControllerFamily._()
    : super(
        retry: null,
        name: r'associationInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssociationInfoControllerProvider call(String associationId) =>
      AssociationInfoControllerProvider._(argument: associationId, from: this);

  @override
  String toString() => r'associationInfoControllerProvider';
}

abstract class _$AssociationInfoController
    extends $AsyncNotifier<AssociationInfo> {
  late final _$args = ref.$arg as String;
  String get associationId => _$args;

  FutureOr<AssociationInfo> build(String associationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AssociationInfo>, AssociationInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AssociationInfo>, AssociationInfo>,
              AsyncValue<AssociationInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
