package org.parish360.core.bookings.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.payments.dto.PaymentInfo;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookingResponse {
    private String id;
    private String bookingCode;
    @NotNull(message = "booked by field cannot be empty")
    private String bookedBy;
    @NotNull(message = "contact information cannot be empty")
    private String contact;
    private String familyCode;
    private String event;
    private String description;
    private String status;
    private String bookingType;
    @NotNull(message = "booked from information cannot be empty")
    private LocalDateTime bookedFrom;
    @NotNull(message = "booked to information cannot be empty")
    private LocalDateTime bookedTo;
    private List<Object> items;
    private PaymentInfo payment;
}
