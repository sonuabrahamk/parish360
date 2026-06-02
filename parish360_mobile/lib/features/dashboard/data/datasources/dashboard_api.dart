import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/parish_report_info.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/statement_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'dashboard_api.g.dart';

@RestApi()
abstract class DashboardApi {
  factory DashboardApi(Dio dio, {String baseUrl}) = _DashboardApi;

  @GET('/dashboard')
  Future<ParishReportInfo> getParishReport();

  @GET('/dashboard/members')
  Future<List<MemberInfo>> getMembersList();

  @GET('/dashboard/account-statement')
  Future<List<StatementInfo>> getStatementInfo(@Query('startDate') String startDate, @Query('endDate') String endDate);
}