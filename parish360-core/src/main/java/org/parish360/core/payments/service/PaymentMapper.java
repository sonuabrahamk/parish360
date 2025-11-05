package org.parish360.core.payments.service;

import org.mapstruct.*;
import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.payments.dto.PaymentInfo;

@Mapper(componentModel = "spring",
        uses = {UUIDUtil.class, TimezoneUtil.class},
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface PaymentMapper {
    // payments mapper
    @Mapping(source = "id", target = "id", qualifiedByName = "uuidToBase64")
    @Mapping(source = "referenceId", target = "referenceId", qualifiedByName = "uuidToBase64")
    PaymentInfo daoToPaymentInfo(Payment payment);

    @Mapping(source = "id", target = "id", qualifiedByName = "base64ToUuid")
    @Mapping(source = "referenceId", target = "referenceId", qualifiedByName = "base64ToUuid")
    Payment paymentInfoToDao(PaymentInfo paymentInfo);

    void mergeNotNullPayment(Payment source, @MappingTarget Payment target);
}
