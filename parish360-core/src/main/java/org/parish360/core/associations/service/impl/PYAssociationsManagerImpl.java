package org.parish360.core.associations.service.impl;

import org.parish360.core.associations.dto.CommitteeMemberInfo;
import org.parish360.core.associations.service.AssociationMapper;
import org.parish360.core.associations.service.PYAssociationsManager;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.associations.CommitteeMember;
import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.parish360.core.dao.repository.associations.AssociationRepository;
import org.parish360.core.dao.repository.associations.CommitteeMemberRepository;
import org.parish360.core.dao.repository.configurations.ParishYearAssociationRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PYAssociationsManagerImpl implements PYAssociationsManager {
    private final AssociationMapper associationMapper;
    private final CommitteeMemberRepository committeeMemberRepository;
    private final ParishYearAssociationRepository parishYearAssociationRepository;

    public PYAssociationsManagerImpl(AssociationMapper associationMapper, AssociationRepository associationRepository, ParishRepository parishRepository, CommitteeMemberRepository committeeMemberRepository, ParishYearAssociationRepository parishYearAssociationRepository) {
        this.associationMapper = associationMapper;
        this.committeeMemberRepository = committeeMemberRepository;
        this.parishYearAssociationRepository = parishYearAssociationRepository;
    }

    @Override
    @Transactional
    public CommitteeMemberInfo addCommitteeMember(String pyAssociationId, CommitteeMemberInfo committeeMemberInfo) {
        // validate parish year association
        ParishYearAssociation parishYearAssociation = parishYearAssociationRepository
                .findById(UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("parish year association information not found"));

        CommitteeMember committeeMember = associationMapper.committeeMemberToDao(committeeMemberInfo);
        committeeMember.setParishYearAssociation(parishYearAssociation);

        return associationMapper.daoToCommitteeMemberInfo(committeeMemberRepository.save(committeeMember));
    }

    @Override
    @Transactional
    public CommitteeMemberInfo updateCommitteeMember(String pyAssociationId, String committeeMemberId,
                                                     CommitteeMemberInfo committeeMemberInfo) {
        // validate current committee member
        CommitteeMember currentCommitteeMember = committeeMemberRepository
                .findByIdAndParishYearAssociation_Id(UUIDUtil.decode(committeeMemberId), UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("committee member information not found"));

        associationMapper
                .mergeNotNullCommitteeMemberToTarget(associationMapper
                        .committeeMemberToDao(committeeMemberInfo), currentCommitteeMember);
        return associationMapper.daoToCommitteeMemberInfo(committeeMemberRepository.save(currentCommitteeMember));
    }

    @Override
    @Transactional(readOnly = true)
    public CommitteeMemberInfo getCommitteeMember(String pyAssociationId, String committeeMemberId) {
        return associationMapper.daoToCommitteeMemberInfo(committeeMemberRepository
                .findByIdAndParishYearAssociation_Id(UUIDUtil.decode(committeeMemberId), UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("committee member information not found")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommitteeMemberInfo> getListOfCommitteeMembers(String pyAssociationId) {
        List<CommitteeMember> committeeMembers = committeeMemberRepository
                .findByParishYearAssociation_Id(UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("committee members information not found"));

        return committeeMembers
                .stream()
                .map(associationMapper::daoToCommitteeMemberInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteCommitteeMember(String pyAssociationId, String committeeMemberId) {
        CommitteeMember committeeMember = committeeMemberRepository
                .findByIdAndParishYearAssociation_Id(UUIDUtil.decode(committeeMemberId), UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("committee member information not found"));
        committeeMemberRepository.delete(committeeMember);
    }
}
