import 'package:parish360_mobile/features/configurations/data/providers/accounts_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_info_controller.g.dart';

@riverpod
class AccountInfoController extends _$AccountInfoController {
  @override
  Future<AccountInfo> build(String accountId) async {
    return await ref.read(accountRepositoryProvider).getAccountInfo(accountId);
  }

  Future<AccountInfo> createAccount(AccountInfo newInfo) async {
    final createdAccount = await ref
        .read(accountRepositoryProvider)
        .createAccount(newInfo);
    if (!ref.mounted) {
      return createdAccount;
    }
    state = AsyncValue.data(createdAccount);
    return createdAccount;
  }

  Future<AccountInfo> updateAccountInfo(
    String accountId,
    AccountInfo updatedInfo,
  ) async {
    final updatedAccount = await ref
        .read(accountRepositoryProvider)
        .updateAccountInfo(accountId, updatedInfo);
    if (!ref.mounted) {
      return updatedAccount;
    }
    state = AsyncValue.data(updatedAccount);
    return updatedAccount;
  }

  Future<void> deleteAccount(String accountId) async {
    await ref.read(accountRepositoryProvider).deleteAccount(accountId);
  }
}
