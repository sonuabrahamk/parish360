// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AsyncValue<LoginResponse>> {
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<LoginResponse> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<LoginResponse>>(value),
    );
  }
}

String _$authControllerHash() => r'f3ff8586b01244064470a45b048f8c128191afc9';

abstract class _$AuthController extends $Notifier<AsyncValue<LoginResponse>> {
  AsyncValue<LoginResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LoginResponse>, AsyncValue<LoginResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LoginResponse>, AsyncValue<LoginResponse>>,
              AsyncValue<LoginResponse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
