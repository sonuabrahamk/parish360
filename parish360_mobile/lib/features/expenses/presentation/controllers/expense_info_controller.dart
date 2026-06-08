import 'package:parish360_mobile/features/expenses/data/providers/expense_providers.dart';
import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_info_controller.g.dart';

@riverpod
class ExpenseInfoController extends _$ExpenseInfoController {
  @override
  Future<ExpenseInfo> build(String expenseId) async {
    return await ref.read(expensesRepositoryProvider).getExpenseInfo(expenseId);
  }

  Future<ExpenseInfo> createExpense(ExpenseInfo expenseInfo) async {
    return await ref
        .read(expensesRepositoryProvider)
        .createExpense(expenseInfo);
  }

  Future<ExpenseInfo> updateExpense(
    String expenseId,
    ExpenseInfo expenseInfo,
  ) async {
    return await ref
        .read(expensesRepositoryProvider)
        .updateExpense(expenseId, expenseInfo);
  }

  Future<void> deleteExpense(String expenseId) async {
    return await ref.read(expensesRepositoryProvider).deleteExpense(expenseId);
  }
}
