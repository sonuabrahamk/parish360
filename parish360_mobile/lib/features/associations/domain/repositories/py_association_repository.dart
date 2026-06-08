import 'package:parish360_mobile/features/associations/domain/entities/associates_request.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';

abstract class PyAssociationRepository {
  Future<CommitteeMemberInfo> addCommitteeMember(
    String pyAssociationId,
    CommitteeMemberInfo committeeMemberInfo,
  );
  Future<CommitteeMemberInfo> updateCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
    CommitteeMemberInfo committeeMemberInfo,
  );
  Future<List<CommitteeMemberInfo>> getCommitteeMembers(String pyAssociationId);
  Future<CommitteeMemberInfo> getCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  );
  Future<void> deleteCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  );
  Future<dynamic> mapAssociates(
    String pyAssociationId,
    AssociatesRequest associatesRequest,
  );
  Future<dynamic> unMapAssociates(
    String pyAssociationId,
    AssociatesRequest associatesRequest,
  );
  Future<dynamic> getAssociates(String pyAssociationId);
}
