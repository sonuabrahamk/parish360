package org.parish360.core.configurations.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.ParishYearInfo;
import org.parish360.core.dao.entities.configurations.ParishYear;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ConfigurationMapper {

    // ParishYear Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    ParishYear parishYearInfoToDao(ParishYearInfo parishYearInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ParishYearInfo daoToParishYearInfo(ParishYear parishYear);

    void mergeNotNullParishYearToTarget(ParishYear source, @MappingTarget ParishYear target);
}
