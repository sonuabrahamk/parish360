// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(expensesApi)
final expensesApiProvider = ExpensesApiProvider._();

final class ExpensesApiProvider
    extends $FunctionalProvider<ExpensesApi, ExpensesApi, ExpensesApi>
    with $Provider<ExpensesApi> {
  ExpensesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesApiHash();

  @$internal
  @override
  $ProviderElement<ExpensesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExpensesApi create(Ref ref) {
    return expensesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpensesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpensesApi>(value),
    );
  }
}

String _$expensesApiHash() => r'5af22d9f0976731be0ffe8587ceb835373458005';

@ProviderFor(expensesRepository)
final expensesRepositoryProvider = ExpensesRepositoryProvider._();

final class ExpensesRepositoryProvider
    extends
        $FunctionalProvider<
          ExpensesRepository,
          ExpensesRepository,
          ExpensesRepository
        >
    with $Provider<ExpensesRepository> {
  ExpensesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExpensesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExpensesRepository create(Ref ref) {
    return expensesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpensesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpensesRepository>(value),
    );
  }
}

String _$expensesRepositoryHash() =>
    r'27782c6a2b5e2f94b17c4f93dd8b50fd8ba251cc';
