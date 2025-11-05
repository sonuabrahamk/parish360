package org.parish360.core.expenses.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExpenseInfo {
    private String id;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;

    @NotNull(message = "payment to field cannot be null")
    private String paidTo;
    private String paidBy;
    private LocalDate date;
    private String description;
    @NotNull(message = "payment amount field cannot be null")
    private BigDecimal amount;
    private String currency;
    private BigDecimal conversionRate;
    private String accountId;
}
