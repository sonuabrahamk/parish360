import 'package:parish360_mobile/features/expenses/data/datasources/expenses_api.dart';
import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';
import 'package:parish360_mobile/features/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesApi _expensesApi;
  ExpensesRepositoryImpl(this._expensesApi);

  @override
  Future<ExpenseInfo> createExpense(ExpenseInfo expenseInfo) async {
    return await _expensesApi.createExpense(expenseInfo);
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    return await _expensesApi.deleteExpense(expenseId);
  }

  @override
  Future<ExpenseInfo> getExpenseInfo(String expenseId) async {
    return await _expensesApi.getExpenseInfo(expenseId);
  }

  @override
  Future<List<ExpenseInfo>> getExpenses() async {
    return await _expensesApi.getExpenses();
  }

  @override
  Future<ExpenseInfo> updateExpense(
    String expenseId,
    ExpenseInfo expenseInfo,
  ) async {
    return await _expensesApi.updateExpense(expenseId, expenseInfo);
  }
}
