package org.parish360.core.configurations.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ServiceInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;
    private String name;
    private String type;
    private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;
    private BigDecimal amount;
    private String currency;
    private BigDecimal conversionRate;
    private String resourceId;
}
