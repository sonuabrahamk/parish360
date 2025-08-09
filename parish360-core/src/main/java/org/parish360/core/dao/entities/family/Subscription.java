package org.parish360.core.dao.entities.family;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;

import java.math.BigDecimal;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "subscriptions")
public class Subscription extends BaseEntity {
    @Column(nullable = false)
    private String year;

    @Column(nullable = false)
    private String month;

    @Column(precision = 19, scale = 2)
    private BigDecimal amount;

    private String currency;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;
}
