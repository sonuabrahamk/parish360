// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accountsApi)
final accountsApiProvider = AccountsApiProvider._();

final class AccountsApiProvider
    extends $FunctionalProvider<AccountsApi, AccountsApi, AccountsApi>
    with $Provider<AccountsApi> {
  AccountsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountsApiHash();

  @$internal
  @override
  $ProviderElement<AccountsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AccountsApi create(Ref ref) {
    return accountsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountsApi>(value),
    );
  }
}

String _$accountsApiHash() => r'edb60f6b8608fdc3b21bcabc084bd3c0260aa1fb';

@ProviderFor(accountRepository)
final accountRepositoryProvider = AccountRepositoryProvider._();

final class AccountRepositoryProvider
    extends
        $FunctionalProvider<
          AccountRepository,
          AccountRepository,
          AccountRepository
        >
    with $Provider<AccountRepository> {
  AccountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountRepository create(Ref ref) {
    return accountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountRepository>(value),
    );
  }
}

String _$accountRepositoryHash() => r'0eb26a1e8eadb5b80eb53cad9e23d170bd5d8f89';
