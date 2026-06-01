import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'accounts_api.g.dart';

@RestApi()
abstract class AccountsApi {
  factory AccountsApi(Dio dio, {String baseUrl}) = _AccountsApi;

  @GET('/configurations/accounts')
  Future<List<AccountInfo>> getAllAccounts();

  @POST('/configurations/accounts')
  Future<AccountInfo> createAccount(@Body() AccountInfo accountInfo);

  @GET('/configurations/accounts/{accountId}')
  Future<AccountInfo> getAccountInfo(@Path('accountId') String accountId);

  @PATCH('/configurations/accounts/{accountId}')
  Future<AccountInfo> updateAccount(
    @Path('accountId') String accountId,
    @Body() AccountInfo accountInfo,
  );

  @DELETE('/configurations/accounts/{accountId}')
  Future<void> deleteAccount(@Path('accountId') String accountId);
}
