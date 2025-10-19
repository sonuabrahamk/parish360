package org.parish360.core.configurations.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ResourceInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;
    @NotNull(message = "resource name cannot be empty")
    private String name;
    private String description;
    private int capacity;
    private BigDecimal amount;
    private String currency;
    private BigDecimal conversionRate;
    private boolean isMassCompatible;
    private boolean isActive;
}
