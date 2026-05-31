import 'package:parish360_mobile/features/configurations/data/datasources/accounts_api.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountsApi _accountsApi;

  AccountRepositoryImpl(this._accountsApi);

  @override
  Future<AccountInfo> createAccount(AccountInfo newInfo) async {
    return await _accountsApi.createAccount(newInfo);
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await _accountsApi.deleteAccount(accountId);
  }

  @override
  Future<AccountInfo> getAccountInfo(String accountId) async {
    return await _accountsApi.getAccountInfo(accountId);
  }

  @override
  Future<List<AccountInfo>> getAllAccounts() async {
    return await _accountsApi.getAllAccounts();
  }

  @override
  Future<AccountInfo> updateAccountInfo(
    String accountId,
    AccountInfo updatedInfo,
  ) async {
    return await _accountsApi.updateAccount(accountId, updatedInfo);
  }
}
