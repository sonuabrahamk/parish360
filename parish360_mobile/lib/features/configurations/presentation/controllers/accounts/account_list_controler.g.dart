// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_controler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountListController)
final accountListControllerProvider = AccountListControllerProvider._();

final class AccountListControllerProvider
    extends $AsyncNotifierProvider<AccountListController, List<AccountInfo>> {
  AccountListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountListControllerHash();

  @$internal
  @override
  AccountListController create() => AccountListController();
}

String _$accountListControllerHash() =>
    r'9869b67e59b444f0891831b30365c8685d00f596';

abstract class _$AccountListController
    extends $AsyncNotifier<List<AccountInfo>> {
  FutureOr<List<AccountInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AccountInfo>>, List<AccountInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AccountInfo>>, List<AccountInfo>>,
              AsyncValue<List<AccountInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
