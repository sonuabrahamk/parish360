import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/configurations/data/datasources/accounts_api.dart';
import 'package:parish360_mobile/features/configurations/data/repositories/account_repository_impl.dart';
import 'package:parish360_mobile/features/configurations/domain/repositories/account_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_providers.g.dart';

@riverpod
AccountsApi accountsApi(Ref ref) {
  return AccountsApi(ref.watch(dioProvider));
}

@riverpod
AccountRepository accountRepository(Ref ref) {
  return AccountRepositoryImpl(ref.watch(accountsApiProvider));
}
