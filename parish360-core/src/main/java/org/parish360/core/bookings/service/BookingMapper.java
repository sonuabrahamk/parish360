package org.parish360.core.bookings.service;

import org.mapstruct.*;
import org.parish360.core.bookings.dto.BookingInfo;
import org.parish360.core.bookings.dto.BookingRequest;
import org.parish360.core.bookings.dto.ServiceIntentionInfo;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.dao.entities.bookings.Booking;
import org.parish360.core.dao.entities.bookings.ServiceIntention;
import org.parish360.core.payments.dto.PaymentInfo;

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

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Booking bookingRequestToDao(BookingRequest bookingRequest);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    Payment paymentInfoToPaymentDao(PaymentInfo paymentInfo);

    void mergeNotNullBookingField(Booking source, @MappingTarget Booking target);

    // Service Intentions mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    ServiceIntentionInfo daoToServiceIntentions(ServiceIntention serviceIntention);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    ServiceIntention serviceIntentionsToDao(ServiceIntentionInfo serviceIntentionInfo);

    void mergeNotNullServiceIntentions(ServiceIntention source, @MappingTarget ServiceIntention target);
}
