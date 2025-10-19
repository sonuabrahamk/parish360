package org.parish360.core.dao.entities.configurations;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.dataowner.Parish;

import java.math.BigDecimal;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "resources")
public class Resource extends BaseEntity {
    @Column(nullable = false, unique = true)
    private String name;
    private String description;
    private int capacity;

    private BigDecimal amount;
    private String currency;
    @Column(name = "conversion_rate")
    private BigDecimal conversionRate;

    @Column(name = "is_mass_compatible")
    private boolean isMassCompatible;

    @Column(name = "is_active")
    private boolean isActive;

    @ManyToOne
    @JoinColumn(name = "parish_id", nullable = false)
    private Parish parish;
}
