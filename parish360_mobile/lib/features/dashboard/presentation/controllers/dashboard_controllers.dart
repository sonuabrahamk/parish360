import 'package:parish360_mobile/features/dashboard/data/providers/dashboard_providers.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/parish_report_info.dart';
import 'package:parish360_mobile/features/dashboard/domain/entities/statement_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controllers.g.dart';

@riverpod
class ParishReportController extends _$ParishReportController {
  @override
  Future<ParishReportInfo> build() async {
    return await ref.watch(dashboardRepositoryProvider).getParishReport();
  }
}

@riverpod
class StatementInfoController extends _$StatementInfoController {
  @override
  Future<List<StatementInfo>> build(String startDate, String endDate) async {
    return await ref
        .watch(dashboardRepositoryProvider)
        .getStatementInfo(startDate, endDate);
  }
}

@riverpod
class MembersListController extends _$MembersListController {
  @override
  Future<List<MemberInfo>> build() async {
    return await ref.watch(dashboardRepositoryProvider).getMembersList();
  }
}

@riverpod
List<MemberInfo> filteredMembersListController(Ref ref, String query) {
  final membersAsync = ref.watch(membersListControllerProvider);

  return membersAsync.maybeWhen(
    data: (members) {
      if (query.isEmpty) {
        return members;
      }
      final lowerQuery = query.toLowerCase();
      return members.where((member) {
        final fullName = '${member.firstName ?? ''} ${member.lastName ?? ''}'
            .toLowerCase();
        final contact = member.contact.toString().toLowerCase();
        final email = member.email.toString().toLowerCase();
        final relationship = member.relationship.toString().toLowerCase();
        final father = member.father.toString().toLowerCase();
        final mother = member.mother.toString().toLowerCase();
        final dob = member.dob.toString().toLowerCase();
        final gender = member.gender.toString().toLowerCase();
        final qualification = member.qualification.toString().toLowerCase();
        final occupation = member.occupation.toString().toLowerCase();

        return fullName.contains(lowerQuery) ||
            contact.contains(lowerQuery) ||
            email.contains(lowerQuery) ||
            relationship.contains(lowerQuery) ||
            father.contains(lowerQuery) ||
            mother.contains(lowerQuery) ||
            dob.contains(lowerQuery) ||
            gender.contains(lowerQuery) ||
            qualification.contains(lowerQuery) ||
            occupation.contains(lowerQuery);
      }).toList();
    },
    orElse: () => [],
  );
}

@riverpod
class MembersSearchQuery extends _$MembersSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}


@riverpod
List<StatementInfo> filteredStatementInfoController(Ref ref, String query, String startDate, String endDate) {
  final statementInfoAsync = ref.watch(statementInfoControllerProvider(startDate, endDate));

  return statementInfoAsync.maybeWhen(
    data: (statements) {
      if (query.isEmpty) {
        return statements;
      }
      final lowerQuery = query.toLowerCase();
      return statements.where((statement){
          final name = statement.accountName.toString().toLowerCase();
          final date = statement.date.toString().toLowerCase();
          final type = statement.type.toString().toLowerCase();
          final party = statement.party.toString().toLowerCase();
          final description = statement.description.toString().toLowerCase();
          final expense = statement.expense.toString().toLowerCase();
          final payment = statement.payment.toString().toLowerCase();
          final currency = statement.currency.toString().toLowerCase();
          return name.contains(lowerQuery) ||
            date.contains(lowerQuery) ||
            type.contains(lowerQuery) ||
            party.contains(lowerQuery) ||
            description.contains(lowerQuery) ||
            expense.contains(lowerQuery) ||
            payment.contains(lowerQuery) ||
            currency.contains(lowerQuery);
      }).toList();
    },
    orElse: () => []
  );
}

@riverpod
class StatementSearchQuery extends _$StatementSearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}