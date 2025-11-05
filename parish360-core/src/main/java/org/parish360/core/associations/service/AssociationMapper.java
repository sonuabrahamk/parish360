package org.parish360.core.associations.service;

import org.mapstruct.*;
import org.parish360.core.associations.dto.CommitteeMemberInfo;
import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.AssociationInfo;
import org.parish360.core.dao.entities.associations.CommitteeMember;
import org.parish360.core.dao.entities.configurations.Association;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class, TimezoneUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface AssociationMapper {
    // Association Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    AssociationInfo daoToAssociationInfo(Association association);

    // Committee Member mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    CommitteeMember committeeMemberToDao(CommitteeMemberInfo committeeMemberInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    CommitteeMemberInfo daoToCommitteeMemberInfo(CommitteeMember committeeMember);

    void mergeNotNullCommitteeMemberToTarget(CommitteeMember source, @MappingTarget CommitteeMember target);
}
