package org.parish360.core.dao.entities.configurations;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.AssociationType;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.dataowner.Parish;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "associations")
public class Association extends BaseEntity {
    @Column(unique = true, nullable = false)
    private String name;

    private String description;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private AssociationType type;

    private String director;
    private String scope;
    private String patron;

    @Column(name = "founded_date")
    private LocalDate foundedDate;

    @Column(name = "is_active")
    private boolean isActive;

    @ManyToOne
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
