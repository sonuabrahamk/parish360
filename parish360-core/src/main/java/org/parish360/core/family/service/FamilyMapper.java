package org.parish360.core.family.service;

import org.mapstruct.*;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Blessing;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.entities.family.Subscription;
import org.parish360.core.family.dto.BlessingInfo;
import org.parish360.core.family.dto.FamilyInfo;
import org.parish360.core.family.dto.MemberInfo;
import org.parish360.core.family.dto.SubscriptionInfo;

import java.time.Month;
import java.time.Year;

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

    // Member Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Member memberInfoToDao(MemberInfo memberInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    MemberInfo daoToMemberInfo(Member member);

    void mergeNotNullMemberFieldToTarget(Member source, @MappingTarget Member target);

    // Blessing Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Blessing blessingInfoToDao(BlessingInfo blessingInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    BlessingInfo daoToBlessingInfo(Blessing blessing);

    void mergeNotNullBlessingFieldToTarget(Blessing source, @MappingTarget Blessing target);

    //Subscription Info Mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    @Mapping(source = "year", target = "year")
    @Mapping(source = "month", target = "month")
    Subscription subscriptionInfoToDao(SubscriptionInfo subscriptionInfo);

    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(source = "year", target = "year")
    @Mapping(source = "month", target = "month")
    SubscriptionInfo daoToSubscriptionInfo(Subscription subscription);

    void mergeNotNullSubscriptionFieldToTarget(Subscription source, @MappingTarget Subscription target);

    // Custom mapping methods
    default Year mapYear(int year) {
        return Year.of(year);
    }

    default int mapYear(Year year) {
        return year.getValue();
    }

    default Month mapMonth(int month) {
        return Month.of(month);
    }

    default int mapMonth(Month month) {
        return month.getValue();
    }
}
