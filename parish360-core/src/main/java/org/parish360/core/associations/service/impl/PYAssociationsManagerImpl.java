package org.parish360.core.associations.service.impl;

import org.parish360.core.associations.dto.AssociatesRequest;
import org.parish360.core.associations.dto.CommitteeMemberInfo;
import org.parish360.core.associations.service.AssociationMapper;
import org.parish360.core.associations.service.PYAssociationsManager;
import org.parish360.core.common.enums.AssociationType;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.associations.Associate;
import org.parish360.core.dao.entities.associations.CommitteeMember;
import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.parish360.core.dao.entities.configurations.Association;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.repository.associations.AssociateRepository;
import org.parish360.core.dao.repository.associations.AssociationRepository;
import org.parish360.core.dao.repository.associations.CommitteeMemberRepository;
import org.parish360.core.dao.repository.configurations.ParishYearAssociationRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class PYAssociationsManagerImpl implements PYAssociationsManager {
    private final AssociationMapper associationMapper;
    private final CommitteeMemberRepository committeeMemberRepository;
    private final ParishYearAssociationRepository parishYearAssociationRepository;
    private final AssociationRepository associationRepository;
    private final MemberRepository memberRepository;
    private final AssociateRepository associateRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final FamilyMapper familyMapper;

    public PYAssociationsManagerImpl(AssociationMapper associationMapper, AssociationRepository associationRepository, ParishRepository parishRepository, CommitteeMemberRepository committeeMemberRepository, ParishYearAssociationRepository parishYearAssociationRepository, AssociationRepository associationRepository1, MemberRepository memberRepository, AssociateRepository associateRepository, FamilyInfoRepository familyInfoRepository, FamilyMapper familyMapper) {
        this.associationMapper = associationMapper;
        this.committeeMemberRepository = committeeMemberRepository;
        this.parishYearAssociationRepository = parishYearAssociationRepository;
        this.associationRepository = associationRepository1;
        this.memberRepository = memberRepository;
        this.associateRepository = associateRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.familyMapper = familyMapper;
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

    @Override
    @Transactional
    public void mapAssociates(String pyAssociationId, AssociatesRequest associatesRequest) {
        // validate parish year association
        ParishYearAssociation parishYearAssociation = parishYearAssociationRepository
                .findById(UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("parish year association information not found"));

        // fetch association information
        Association association = associationRepository
                .findById(parishYearAssociation.getAssociation().getId())
                .orElseThrow(() -> new ResourceNotFoundException("association information is not found"));

        Set<UUID> associateUUIDs = associatesRequest.getAssociates()
                .stream().map(UUIDUtil::decode).collect(Collectors.toSet());

        if (association.getType() == AssociationType.MEMBER) {
            // validate member ids
            List<Member> members = memberRepository.findAllById(associateUUIDs);

            if (members.size() != associatesRequest.getAssociates().size()) {
                throw new BadRequestException("some member ids are not valid");
            }

            //group all associates information
            List<Associate> associates = members.stream()
                    .map(member -> {
                        Associate associate = new Associate();
                        associate.setParishYearAssociation(parishYearAssociation);
                        associate.setAssociates(member.getId());
                        return associate;
                    }).toList();

            associateRepository.saveAll(associates);
        }
        if (association.getType() == AssociationType.ASSOCIATION) {
            // validate association ids
            List<Association> associations = associationRepository.findAllById(associateUUIDs);
            if (associations.size() != associatesRequest.getAssociates().size()) {
                throw new BadRequestException("some association ids are not valid");
            }

            //group all associates information
            List<Associate> associates = associations.stream()
                    .map(assoc -> {
                        Associate associate = new Associate();
                        associate.setParishYearAssociation(parishYearAssociation);
                        associate.setAssociates(assoc.getId());
                        return associate;
                    }).toList();

            associateRepository.saveAll(associates);
        }
        if (association.getType() == AssociationType.FAMILY) {
            // validate association ids
            List<Family> families = familyInfoRepository.findAllById(associateUUIDs);
            if (families.size() != associatesRequest.getAssociates().size()) {
                throw new BadRequestException("some association ids are not valid");
            }

            //group all associates information
            List<Associate> associates = families.stream()
                    .map(family -> {
                        Associate associate = new Associate();
                        associate.setParishYearAssociation(parishYearAssociation);
                        associate.setAssociates(family.getId());
                        return associate;
                    }).toList();

            associateRepository.saveAll(associates);
        }
    }

    @Override
    @Transactional
    public void unMapAssociates(String pyAssociationId, AssociatesRequest associatesRequest) {
        Set<UUID> associateUUIDs = associatesRequest.getAssociates()
                .stream().map(UUIDUtil::decode).collect(Collectors.toSet());
        List<Associate> associates = associateRepository
                .findAllByParishYearAssociation_IdAndAssociatesIn(UUIDUtil.decode(pyAssociationId), associateUUIDs)
                .orElseThrow(() -> new ResourceNotFoundException("could not find associate information"));

        if (associates.size() != associatesRequest.getAssociates().size()) {
            throw new BadRequestException("some associates are not matching");
        }
        associateRepository.deleteAll(associates);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Object> getAssociatesList(String pyAssociationId) {
        // find all associates for the parish year
        List<Associate> associates = associateRepository
                .findAllByParishYearAssociation_Id(UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find associate information"));
        
        if (associates.isEmpty()) {
            return List.of();
        }

        // get the list of associated UUID
        List<UUID> associateUUIDs = associates.stream().map(Associate::getAssociates).toList();

        // fetch ParishYearAssociation information
        ParishYearAssociation parishYearAssociation = parishYearAssociationRepository
                .findById(UUIDUtil.decode(pyAssociationId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish year information"));

        // fetch association information
        Association association = associationRepository
                .findById(parishYearAssociation.getAssociation().getId())
                .orElseThrow(() -> new ResourceNotFoundException("association information is not found"));

        return switch (association.getType()) {
            case AssociationType.ASSOCIATION -> {
                List<Association> associationsList = associationRepository.findAllById(associateUUIDs);
                yield associationsList.stream().map(associationMapper::daoToAssociationInfo).collect(Collectors.toList());
            }
            case AssociationType.FAMILY -> {
                List<Family> families = familyInfoRepository.findAllById(associateUUIDs);
                yield families.stream().map(familyMapper::daoToFamilyInfo).collect(Collectors.toList());
            }
            case AssociationType.MEMBER -> {
                List<Member> members = memberRepository.findAllById(associateUUIDs);
                yield members.stream().map(familyMapper::daoToMemberInfo).collect(Collectors.toList());
            }
        };
    }
}
