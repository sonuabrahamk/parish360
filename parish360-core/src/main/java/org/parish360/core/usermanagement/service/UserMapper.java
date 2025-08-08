package org.parish360.core.usermanagement.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.usermanagement.dto.UserInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface UserMapper {

    //    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
//    @Mapping(source = "dataowner", target = "dataowner", qualifiedByName = "uuidToBase64")
    @Mapping(target = "password", ignore = true)
    UserInfo daoToUserInfo(User user);

    //    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
//    @Mapping(source = "dataowner", target = "dataowner", qualifiedByName = "base64ToUuid")
    User userInfoToDao(UserInfo userInfo);

    void mergeUserIfTargetFieldIsNull(User source, @MappingTarget User target);
}
