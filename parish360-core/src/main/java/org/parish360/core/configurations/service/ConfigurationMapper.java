package org.parish360.core.configurations.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.AssociationInfo;
import org.parish360.core.configurations.dto.PYAssociationResponse;
import org.parish360.core.configurations.dto.ParishYearInfo;
import org.parish360.core.configurations.dto.ResourceInfo;
import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.parish360.core.dao.entities.configurations.Association;
import org.parish360.core.dao.entities.configurations.ParishYear;
import org.parish360.core.dao.entities.configurations.Resource;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ConfigurationMapper {
    // Association Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    AssociationInfo daoToAssociationInfo(Association association);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Association associationInfoToDao(AssociationInfo associationInfo);

    void mergeNotNullAssociationToTarget(Association source, @MappingTarget Association target);

    // ParishYear Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    ParishYear parishYearInfoToDao(ParishYearInfo parishYearInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ParishYearInfo daoToParishYearInfo(ParishYear parishYear);

    void mergeNotNullParishYearToTarget(ParishYear source, @MappingTarget ParishYear target);

    // Parish Year Association Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    PYAssociationResponse daoToPYAssociationResponse(ParishYearAssociation parishYearAssociation);

    // Resource mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ResourceInfo daoToResourceInfo(Resource resource);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Resource resourceInfoToDao(ResourceInfo resourceInfo);

    void mergeNotNullResourceInfo(Resource source, @MappingTarget Resource target);
}
