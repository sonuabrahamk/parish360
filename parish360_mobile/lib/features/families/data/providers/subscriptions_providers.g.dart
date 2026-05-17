// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subscriptionsApi)
final subscriptionsApiProvider = SubscriptionsApiProvider._();

final class SubscriptionsApiProvider
    extends
        $FunctionalProvider<
          SubscriptionsApi,
          SubscriptionsApi,
          SubscriptionsApi
        >
    with $Provider<SubscriptionsApi> {
  SubscriptionsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionsApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionsApiHash();

  @$internal
  @override
  $ProviderElement<SubscriptionsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubscriptionsApi create(Ref ref) {
    return subscriptionsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubscriptionsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubscriptionsApi>(value),
    );
  }
}

String _$subscriptionsApiHash() => r'3018bce0d1352716c24306bba2ad8fdd548b63db';

@ProviderFor(subscriptionRepository)
final subscriptionRepositoryProvider = SubscriptionRepositoryProvider._();

final class SubscriptionRepositoryProvider
    extends
        $FunctionalProvider<
          SubscriptionRepository,
          SubscriptionRepository,
          SubscriptionRepository
        >
    with $Provider<SubscriptionRepository> {
  SubscriptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubscriptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubscriptionRepository create(Ref ref) {
    return subscriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubscriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubscriptionRepository>(value),
    );
  }
}

String _$subscriptionRepositoryHash() =>
    r'6d2da866554e54d504e9339480dfcef47939364b';
