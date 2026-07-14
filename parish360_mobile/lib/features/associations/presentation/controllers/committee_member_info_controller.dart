import 'package:parish360_mobile/features/associations/data/providers/py_association_providers.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'committee_member_info_controller.g.dart';

@riverpod
class CommitteeMemberInfoController extends _$CommitteeMemberInfoController {
  @override
  Future<CommitteeMemberInfo> build(
    String pyAssociationId,
    String committeeMemberId,
  ) {
    return ref
        .read(pyAssociationRepositoryProvider)
        .getCommitteeMember(pyAssociationId, committeeMemberId);
  }

  Future<CommitteeMemberInfo> addCommitteeMember(
    String pyAssociationId,
    CommitteeMemberInfo committeeMemberInfo,
  ) async {
    return await ref
        .read(pyAssociationRepositoryProvider)
        .addCommitteeMember(pyAssociationId, committeeMemberInfo);
  }

  Future<CommitteeMemberInfo> updateCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
    CommitteeMemberInfo committeeMemberInfo,
  ) async {
    return await ref
        .read(pyAssociationRepositoryProvider)
        .updateCommitteeMember(
          pyAssociationId,
          committeeMemberId,
          committeeMemberInfo,
        );
  }

  Future<CommitteeMemberInfo> getCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  ) async {
    return await ref
        .read(pyAssociationRepositoryProvider)
        .getCommitteeMember(pyAssociationId, committeeMemberId);
  }

  Future<void> deleteCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  ) async {
    return await ref
        .read(pyAssociationRepositoryProvider)
        .deleteCommitteeMember(pyAssociationId, committeeMemberId);
  }
}
