package org.parish360.core.dao.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.PaymentType;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;

import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "payments")
public class Payment extends BaseEntity {
    @Column(name = "paid_to")
    private String paidTo;

    @Column(name = "paid_by")
    private String paidBy;

    @Enumerated(EnumType.STRING)
    private PaymentType type;

    private String description;
    private BigDecimal amount;
    private String currency;

    @Column(name = "conversion_rate")
    private BigDecimal conversionRate;

    @Column(name = "reference_id")
    private UUID referenceId;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
