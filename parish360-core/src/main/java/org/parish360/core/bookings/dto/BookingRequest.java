package org.parish360.core.bookings.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.payments.dto.PaymentInfo;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookingRequest {
    private String id;
    private String bookingCode;
    @NotNull(message = "booked by field cannot be empty")
    private String bookedBy;
    @NotNull(message = "contact information cannot be empty")
    private String contact;
    private String familyCode;
    private String event;
    private String description;
    private String bookingType;
    @NotNull(message = "booked from information cannot be empty")
    private LocalDateTime bookedFrom;
    @NotNull(message = "booked to information cannot be empty")
    private LocalDateTime bookedTo;
    private String[] items;
    private PaymentInfo payment;
}
