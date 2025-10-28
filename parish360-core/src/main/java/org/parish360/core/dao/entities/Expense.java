package org.parish360.core.dao.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "expenses")
public class Expense extends BaseEntity {
    @Column(name = "paid_by")
    private String paidBy;

    @Column(name = "paid_to")
    private String paidTo;

    private LocalDate date;
    private String description;
    private BigDecimal amount;
    private String currency;

    @Column(name = "conversion_rate")
    private BigDecimal conversionRate;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
