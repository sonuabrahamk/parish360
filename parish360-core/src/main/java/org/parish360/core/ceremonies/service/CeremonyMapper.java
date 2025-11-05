package org.parish360.core.ceremonies.service;

import org.mapstruct.*;
import org.parish360.core.ceremonies.dto.CeremonyInfo;
import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.ceremonies.Ceremony;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class, TimezoneUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface CeremonyMapper {
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    CeremonyInfo daoToCeremonyInfo(Ceremony ceremony);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Ceremony ceremonyInfoToDao(CeremonyInfo ceremonyInfo);

    void mergeNotNullCeremonyFields(Ceremony source, @MappingTarget Ceremony target);
}
