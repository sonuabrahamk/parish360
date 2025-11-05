package org.parish360.core.configurations.service;

import org.mapstruct.*;
import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.*;
import org.parish360.core.dao.entities.associations.ParishYearAssociation;
import org.parish360.core.dao.entities.configurations.*;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class, TimezoneUtil.class},
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

    //Service mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Services serviceInfoToDao(ServiceInfo serviceInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ServiceInfo daoToServiceInfo(Services service);

    // Account Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Account accountInfoToDao(AccountInfo accountInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    AccountInfo daoToAccountInfo(Account account);

    void mergeNotNullAccountInfo(Account source, @MappingTarget Account target);
}
