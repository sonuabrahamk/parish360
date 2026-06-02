import 'package:parish360_mobile/features/dashboard/domain/entities/parish_report_info.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/statement_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

abstract class DashboardRepository {
  Future<ParishReportInfo> getParishReport();
  Future<List<StatementInfo>> getStatementInfo(String startDate, String endDate);
  Future<List<MemberInfo>> getMembersList();
}