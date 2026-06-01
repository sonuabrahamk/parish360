// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountInfoController)
final accountInfoControllerProvider = AccountInfoControllerFamily._();

final class AccountInfoControllerProvider
    extends $AsyncNotifierProvider<AccountInfoController, AccountInfo> {
  AccountInfoControllerProvider._({
    required AccountInfoControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accountInfoControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountInfoControllerHash();

  @override
  String toString() {
    return r'accountInfoControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AccountInfoController create() => AccountInfoController();

  @override
  bool operator ==(Object other) {
    return other is AccountInfoControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountInfoControllerHash() =>
    r'4f8a913822302649242799a4346715bebd31ffcc';

final class AccountInfoControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AccountInfoController,
          AsyncValue<AccountInfo>,
          AccountInfo,
          FutureOr<AccountInfo>,
          String
        > {
  AccountInfoControllerFamily._()
    : super(
        retry: null,
        name: r'accountInfoControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AccountInfoControllerProvider call(String accountId) =>
      AccountInfoControllerProvider._(argument: accountId, from: this);

  @override
  String toString() => r'accountInfoControllerProvider';
}

abstract class _$AccountInfoController extends $AsyncNotifier<AccountInfo> {
  late final _$args = ref.$arg as String;
  String get accountId => _$args;

  FutureOr<AccountInfo> build(String accountId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AccountInfo>, AccountInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AccountInfo>, AccountInfo>,
              AsyncValue<AccountInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
