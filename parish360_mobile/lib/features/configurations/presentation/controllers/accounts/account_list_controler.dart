import 'package:parish360_mobile/features/configurations/data/providers/accounts_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_list_controler.g.dart';

@riverpod
class AccountListController extends _$AccountListController {
  @override
  Future<List<AccountInfo>> build() async {
    return await ref.read(accountRepositoryProvider).getAllAccounts();
  }
}