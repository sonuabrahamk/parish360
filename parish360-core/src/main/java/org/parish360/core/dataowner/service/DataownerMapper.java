package org.parish360.core.dataowner.service;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Diocese;
import org.parish360.core.dao.entities.dataowner.Forane;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dataowner.dto.DioceseInfo;
import org.parish360.core.dataowner.dto.ForaneInfo;
import org.parish360.core.dataowner.dto.ParishInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface DataownerMapper {

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Diocese dioceseInfoToDao(DioceseInfo dioceseInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    DioceseInfo daoToDioceseInfo(Diocese diocese);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Forane foraneInfoToDao(ForaneInfo foraneInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ForaneInfo daoToForaneInfo(Forane forane);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Parish parishInfoToDao(ParishInfo parishInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ParishInfo daoToParishInfo(Parish parish);
}
