package org.parish360.core.bookings.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.configurations.dto.ResourceInfo;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookingInfo {
    private String id;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;

    private String bookingCode;
    @NotNull(message = "booked by field cannot be empty")
    private String bookedBy;
    @NotNull(message = "contact information cannot be empty")
    private String contact;
    private String familyCode;
    private String event;
    private String description;
    private String bookingType;
    private BigDecimal totalAmount;
    private BigDecimal amountPaid;
    private String currency;
    private BigDecimal conversionRate;
    @NotNull(message = "booked from information cannot be empty")
    private LocalDateTime bookedFrom;
    @NotNull(message = "booked to information cannot be empty")
    private LocalDateTime bookedTo;
    private String resourceId;
    private String status;
    private String paymentStatus;
    private ResourceInfo resource;
    private ServiceIntentionInfo serviceIntentionInfo;
}
