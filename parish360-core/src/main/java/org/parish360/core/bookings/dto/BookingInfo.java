package org.parish360.core.bookings.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookingInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "booked by field cannot be empty")
    private String bookedBy;
    @NotNull(message = "booked from information cannot be empty")
    private LocalDateTime bookedFrom;
    @NotNull(message = "booked to information cannot be empty")
    private LocalDateTime bookedTo;
    @NotNull(message = "contact information cannot be empty")
    private String contact;
    private String description;
    private String event;
    private String status;
    private String resourceId;
    private String familyCode;
}
