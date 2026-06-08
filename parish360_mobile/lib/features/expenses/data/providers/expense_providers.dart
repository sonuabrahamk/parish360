import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/expenses/data/datasources/expenses_api.dart';
import 'package:parish360_mobile/features/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:parish360_mobile/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_providers.g.dart';

@riverpod
ExpensesApi expensesApi(Ref ref) {
  return ExpensesApi(ref.watch(dioProvider));
}

@riverpod
ExpensesRepository expensesRepository(Ref ref) {
  return ExpensesRepositoryImpl(ref.watch(expensesApiProvider));
}
