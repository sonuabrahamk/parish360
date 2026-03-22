// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_index_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModuleIndex)
final moduleIndexProvider = ModuleIndexProvider._();

final class ModuleIndexProvider extends $NotifierProvider<ModuleIndex, int> {
  ModuleIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moduleIndexHash();

  @$internal
  @override
  ModuleIndex create() => ModuleIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$moduleIndexHash() => r'a5398649a930c9e551efc941d996d5348ad6fb5f';

abstract class _$ModuleIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
