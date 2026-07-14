import 'package:parish360_mobile/features/associations/data/providers/py_association_providers.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'committee_member_list_controller.g.dart';

@riverpod
class CommitteeMemberListController extends _$CommitteeMemberListController {
  @override
  Future<List<CommitteeMemberInfo>> build(String pyAssociationId) async {
    return await ref
        .read(pyAssociationRepositoryProvider)
        .getCommitteeMembers(pyAssociationId);
  }
}

@riverpod
List<CommitteeMemberInfo> filteredCommitteeMembers(
  Ref ref,
  String pyAssociationId,
  String filter,
) {
  final committeeMembersAsync = ref.watch(
    committeeMemberListControllerProvider(pyAssociationId),
  );

  return committeeMembersAsync.when(
    data: (committeeMembers) {
      final lowerFilter = filter.toLowerCase();

      return committeeMembers.where((member) {
        final name = member.name?.toLowerCase() ?? '';
        final type = member.contact?.toLowerCase() ?? '';
        final designation = member.designation?.toLowerCase() ?? '';
        final email = member.email?.toLowerCase() ?? '';

        return name.contains(lowerFilter) ||
            type.contains(lowerFilter) ||
            email.contains(lowerFilter) ||
            designation.contains(lowerFilter);
      }).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
