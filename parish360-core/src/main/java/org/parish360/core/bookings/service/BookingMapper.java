package org.parish360.core.bookings.service;

import org.mapstruct.*;
import org.parish360.core.bookings.dto.BookingInfo;
import org.parish360.core.bookings.dto.ServiceIntentionInfo;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.bookings.Booking;
import org.parish360.core.dao.entities.bookings.ServiceIntention;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface BookingMapper {
    // Booking mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    BookingInfo daoToBookingInfo(Booking booking);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Booking bookingInfoToDao(BookingInfo booingInfo);

    void mergeNotNullBookingField(Booking source, @MappingTarget Booking target);

    // Service Intentions mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ServiceIntentionInfo daoToServiceIntentions(ServiceIntention serviceIntention);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    ServiceIntention serviceIntentionsToDao(ServiceIntentionInfo serviceIntentionInfo);

    void mergeNotNullServiceIntentions(ServiceIntention source, @MappingTarget ServiceIntention target);
}
