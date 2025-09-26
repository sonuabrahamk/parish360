package org.parish360.core.associations.service;

import org.parish360.core.associations.dto.CommitteeMemberInfo;

import java.util.List;

public interface PYAssociationsManager {
    CommitteeMemberInfo addCommitteeMember(String pyAssociationId, CommitteeMemberInfo committeeMemberInfo);

    CommitteeMemberInfo updateCommitteeMember(String pyAssociationId, String committeeMemberId,
                                              CommitteeMemberInfo committeeMemberInfo);

    CommitteeMemberInfo getCommitteeMember(String pyAssociationId, String committeeMemberId);

    List<CommitteeMemberInfo> getListOfCommitteeMembers(String pyAssociationId);

    void deleteCommitteeMember(String pyAssociationId, String committeeMemberId);
}
