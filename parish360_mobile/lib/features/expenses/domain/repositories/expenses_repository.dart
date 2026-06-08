import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseInfo>> getExpenses();
  Future<ExpenseInfo> getExpenseInfo(String expenseId);
  Future<ExpenseInfo> createExpense(ExpenseInfo expenseInfo);
  Future<ExpenseInfo> updateExpense(String expenseId, ExpenseInfo expenseInfo);
  Future<void> deleteExpense(String expenseId);
}
