package org.parish360.core.auth.service;

import org.mapstruct.*;
import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.usermanagement.dto.UserInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class, TimezoneUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface AuthServiceMapper {
    // UserInfo mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(target = "password", ignore = true)
    UserInfo daoToUserInfo(User user);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    User userInfoToDao(UserInfo userInfo);

    void mergeNotNullUserFields(User source, @MappingTarget User target);
}
