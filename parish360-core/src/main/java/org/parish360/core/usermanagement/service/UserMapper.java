package org.parish360.core.usermanagement.service;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.parish360.core.dao.entity.usermanagement.User;
import org.parish360.core.usermanagement.dto.UserInfo;
import org.parish360.core.util.UUIDUtil;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface UserMapper {

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(target = "password", ignore = true)
    UserInfo daoToUserInfo(User user);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    User userInfoToDao(UserInfo userInfo);
}
