import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'expenses_api.g.dart';

@RestApi()
abstract class ExpensesApi {
  factory ExpensesApi(Dio dio, {String baseUrl}) = _ExpensesApi;

  @GET('/expenses')
  Future<List<ExpenseInfo>> getExpenses();

  @GET('/expenses/{expenseId}')
  Future<ExpenseInfo> getExpenseInfo(@Path('expenseId') String expenseId);

  @POST('/expenses')
  Future<ExpenseInfo> createExpense(@Body() ExpenseInfo expenseInfo);

  @PATCH('/expenses/{expenseId}')
  Future<ExpenseInfo> updateExpense(
    @Path('expenseId') String expenseId,
    @Body() ExpenseInfo expenseInfo,
  );

  @DELETE('/expenses/{expenseId}')
  Future<void> deleteExpense(@Path('expenseId') String expenseId);
}
