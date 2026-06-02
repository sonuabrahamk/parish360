import 'package:parish360_mobile/features/dashboard/data/datasources/dashboard_api.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/parish_report_info.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/statement_info.dart';
import 'package:parish360_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApi _dashboardApi;

  DashboardRepositoryImpl(this._dashboardApi);
  
  @override
  Future<List<MemberInfo>> getMembersList() async {
    return await _dashboardApi.getMembersList();
  }

  @override
  Future<ParishReportInfo> getParishReport() async {
    return await _dashboardApi.getParishReport();
  }

  @override
  Future<List<StatementInfo>> getStatementInfo(String startDate, String endDate) async {
    return await _dashboardApi.getStatementInfo(startDate, endDate);
  }
}