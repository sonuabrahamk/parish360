// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscellaneous_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(miscellaneousApi)
final miscellaneousApiProvider = MiscellaneousApiProvider._();

final class MiscellaneousApiProvider
    extends
        $FunctionalProvider<
          MiscellaneousApi,
          MiscellaneousApi,
          MiscellaneousApi
        >
    with $Provider<MiscellaneousApi> {
  MiscellaneousApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'miscellaneousApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$miscellaneousApiHash();

  @$internal
  @override
  $ProviderElement<MiscellaneousApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MiscellaneousApi create(Ref ref) {
    return miscellaneousApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MiscellaneousApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MiscellaneousApi>(value),
    );
  }
}

String _$miscellaneousApiHash() => r'83a9758452eae0a3c4d6d9585ab27807efb85fc7';

@ProviderFor(miscellaneousRepository)
final miscellaneousRepositoryProvider = MiscellaneousRepositoryProvider._();

final class MiscellaneousRepositoryProvider
    extends
        $FunctionalProvider<
          MiscellaneousRepository,
          MiscellaneousRepository,
          MiscellaneousRepository
        >
    with $Provider<MiscellaneousRepository> {
  MiscellaneousRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'miscellaneousRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$miscellaneousRepositoryHash();

  @$internal
  @override
  $ProviderElement<MiscellaneousRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MiscellaneousRepository create(Ref ref) {
    return miscellaneousRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MiscellaneousRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MiscellaneousRepository>(value),
    );
  }
}

String _$miscellaneousRepositoryHash() =>
    r'50dd4dcdf5895dec2ce2f2adf54902339d5c78d2';
