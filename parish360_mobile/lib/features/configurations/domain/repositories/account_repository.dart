import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';

abstract class AccountRepository {
  Future<List<AccountInfo>> getAllAccounts();
  Future<AccountInfo> getAccountInfo(String accountId);
  Future<AccountInfo> updateAccountInfo(
    String accountId,
    AccountInfo updatedInfo,
  );
  Future<AccountInfo> createAccount(AccountInfo newInfo);
  Future<void> deleteAccount(String accountId);
}
