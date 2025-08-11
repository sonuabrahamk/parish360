package org.parish360.core.family.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.family.dto.FamilyInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface FamilyMapper {

    // Family Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Family familyInfoToDao(FamilyInfo familyInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    FamilyInfo daoToFamilyInfo(Family family);

    void mergeNotNullFamilyFieldToTarget(Family source, @MappingTarget Family target);
}
