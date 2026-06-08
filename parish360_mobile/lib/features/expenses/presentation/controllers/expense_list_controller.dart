import 'package:parish360_mobile/features/expenses/data/providers/expense_providers.dart';
import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_list_controller.g.dart';

@riverpod
class ExpenseListController extends _$ExpenseListController {
  @override
  Future<List<ExpenseInfo>> build() async {
    return await ref.read(expensesRepositoryProvider).getExpenses();
  }
}

@riverpod
List<ExpenseInfo> filteredExpenses(Ref ref, String filter) {
  final expensesListAsync = ref.watch(expenseListControllerProvider);

  return expensesListAsync.when(
    data: (expenses) {
      final lowerFilter = filter.toLowerCase();

      return expenses.where((expense) {
        final date = expense.date?.toString().toLowerCase() ?? '';
        final paidTo = expense.paidTo?.toLowerCase() ?? '';
        final paidBy = expense.paidBy?.toLowerCase() ?? '';
        final amount = expense.amount?.toString().toLowerCase() ?? '';
        final currency = expense.currency?.toLowerCase() ?? '';
        final description = expense.description?.toLowerCase() ?? '';

        return date.contains(lowerFilter) ||
            paidTo.contains(lowerFilter) ||
            paidBy.contains(lowerFilter) ||
            amount.contains(lowerFilter) ||
            currency.contains(lowerFilter) ||
            description.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
