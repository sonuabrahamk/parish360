package org.parish360.core.family.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.Month;
import java.time.Year;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "year is not mentioned")
    private Year year;

    @NotNull(message = "month is not mentioned")
    private Month month;

    private BigDecimal amount;
    private String currency;
    private String familyId;
}
