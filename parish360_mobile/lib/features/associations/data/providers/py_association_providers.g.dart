// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'py_association_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pyAssociationsApi)
final pyAssociationsApiProvider = PyAssociationsApiProvider._();

final class PyAssociationsApiProvider
    extends
        $FunctionalProvider<
          PyAssociationsApi,
          PyAssociationsApi,
          PyAssociationsApi
        >
    with $Provider<PyAssociationsApi> {
  PyAssociationsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pyAssociationsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pyAssociationsApiHash();

  @$internal
  @override
  $ProviderElement<PyAssociationsApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PyAssociationsApi create(Ref ref) {
    return pyAssociationsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PyAssociationsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PyAssociationsApi>(value),
    );
  }
}

String _$pyAssociationsApiHash() => r'645d3a431c0a8d353fd59b88db41ddf51ec88c37';

@ProviderFor(pyAssociationRepository)
final pyAssociationRepositoryProvider = PyAssociationRepositoryProvider._();

final class PyAssociationRepositoryProvider
    extends
        $FunctionalProvider<
          PyAssociationRepository,
          PyAssociationRepository,
          PyAssociationRepository
        >
    with $Provider<PyAssociationRepository> {
  PyAssociationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pyAssociationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pyAssociationRepositoryHash();

  @$internal
  @override
  $ProviderElement<PyAssociationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PyAssociationRepository create(Ref ref) {
    return pyAssociationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PyAssociationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PyAssociationRepository>(value),
    );
  }
}

String _$pyAssociationRepositoryHash() =>
    r'b955bb2148e28bbf77136d24ad66bddcf642f07b';
