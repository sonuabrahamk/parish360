package org.parish360.core.dao.entities.configurations;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.dataowner.Parish;

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
    @Column(name = "is_mass_compatible")
    private boolean isMassCompatible;

    @ManyToOne
    @JoinColumn(name = "parish_id", nullable = false)
    private Parish parish;
}
