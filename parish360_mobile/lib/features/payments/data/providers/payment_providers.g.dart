// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(paymentsApi)
final paymentsApiProvider = PaymentsApiProvider._();

final class PaymentsApiProvider
    extends $FunctionalProvider<PaymentsApi, PaymentsApi, PaymentsApi>
    with $Provider<PaymentsApi> {
  PaymentsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsApiHash();

  @$internal
  @override
  $ProviderElement<PaymentsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PaymentsApi create(Ref ref) {
    return paymentsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsApi>(value),
    );
  }
}

String _$paymentsApiHash() => r'0c42def95cb227dd1c9fa9172d27b12e7f838dae';

@ProviderFor(paymentsRepository)
final paymentsRepositoryProvider = PaymentsRepositoryProvider._();

final class PaymentsRepositoryProvider
    extends
        $FunctionalProvider<
          PaymentsRepository,
          PaymentsRepository,
          PaymentsRepository
        >
    with $Provider<PaymentsRepository> {
  PaymentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PaymentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentsRepository create(Ref ref) {
    return paymentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsRepository>(value),
    );
  }
}

String _$paymentsRepositoryHash() =>
    r'41c9f2ae231bd477e5e38d14c5e521150383f18f';
