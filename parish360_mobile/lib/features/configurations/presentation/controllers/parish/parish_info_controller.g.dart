// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ParishInfoController)
final parishInfoControllerProvider = ParishInfoControllerProvider._();

final class ParishInfoControllerProvider
    extends $AsyncNotifierProvider<ParishInfoController, ParishInfo> {
  ParishInfoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parishInfoControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parishInfoControllerHash();

  @$internal
  @override
  ParishInfoController create() => ParishInfoController();
}

String _$parishInfoControllerHash() =>
    r'121fd62dea626949a75dfe79ca2701e40a204546';

abstract class _$ParishInfoController extends $AsyncNotifier<ParishInfo> {
  FutureOr<ParishInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ParishInfo>, ParishInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ParishInfo>, ParishInfo>,
              AsyncValue<ParishInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
