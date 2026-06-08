import 'package:parish360_mobile/features/associations/data/datasources/py_associations_api.dart';
import 'package:parish360_mobile/features/associations/domain/entities/associates_request.dart';
import 'package:parish360_mobile/features/associations/domain/entities/committee_member_info.dart';
import 'package:parish360_mobile/features/associations/domain/repositories/py_association_repository.dart';

class PyAssociationRepositoryImpl implements PyAssociationRepository {
  final PyAssociationsApi _pyAssociationsApi;

  PyAssociationRepositoryImpl(this._pyAssociationsApi);

  @override
  Future<CommitteeMemberInfo> addCommitteeMember(
    String pyAssociationId,
    CommitteeMemberInfo committeeMemberInfo,
  ) async {
    return await _pyAssociationsApi.addCommitteeMember(
      pyAssociationId,
      committeeMemberInfo,
    );
  }

  @override
  Future<void> deleteCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  ) async {
    return await _pyAssociationsApi.deleteCommitteeMember(
      pyAssociationId,
      committeeMemberId,
    );
  }

  @override
  Future<dynamic> getAssociates(String pyAssociationId) async {
    return await _pyAssociationsApi.getAssociates(pyAssociationId);
  }

  @override
  Future<CommitteeMemberInfo> getCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
  ) async {
    return await _pyAssociationsApi.getCommitteeMember(
      pyAssociationId,
      committeeMemberId,
    );
  }

  @override
  Future<List<CommitteeMemberInfo>> getCommitteeMembers(
    String pyAssociationId,
  ) async {
    return await _pyAssociationsApi.getCommitteeMembers(pyAssociationId);
  }

  @override
  Future<dynamic> mapAssociates(
    String pyAssociationId,
    AssociatesRequest associatesRequest,
  ) async {
    return await _pyAssociationsApi.mapAssociates(
      pyAssociationId,
      associatesRequest,
    );
  }

  @override
  Future<dynamic> unMapAssociates(
    String pyAssociationId,
    AssociatesRequest associatesRequest,
  ) async {
    return await _pyAssociationsApi.unMapAssociates(
      pyAssociationId,
      associatesRequest,
    );
  }

  @override
  Future<CommitteeMemberInfo> updateCommitteeMember(
    String pyAssociationId,
    String committeeMemberId,
    CommitteeMemberInfo committeeMemberInfo,
  ) async {
    return await _pyAssociationsApi.updateCommitteeMember(
      pyAssociationId,
      committeeMemberId,
      committeeMemberInfo,
    );
  }
}
