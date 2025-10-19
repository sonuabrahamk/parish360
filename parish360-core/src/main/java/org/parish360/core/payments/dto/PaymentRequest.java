package org.parish360.core.payments.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.PaymentType;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PaymentRequest {
    @NotNull(message = "payment to field cannot be null")
    private String paidTo;
    @NotNull(message = "payee field cannot be null")
    private String payee;
    @NotNull(message = "payment type field cannot be null")
    private PaymentType type;
    private String description;
    @NotNull(message = "payment amount field cannot be null")
    private BigDecimal amount;
    private String currency;
    private BigDecimal conversionRate;
    private String paymentMode;
    private String accountId;
    private String familyCode;
    private String bookingCode;
    private LocalDate subscriptionFrom;
    private LocalDate subscriptionTo;
    private String referenceId;
    private String parishId;
}
