package org.parish360.core.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StatementResponse {
    private String accountName;
    private LocalDate date;
    private String type;
    private String party;
    private String description;
    private BigDecimal expense;
    private BigDecimal payment;
    private String currency;
}
