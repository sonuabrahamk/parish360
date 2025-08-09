package org.parish360.core.dao.entities.associations;

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
@Table(name = "accounts")
public class Account extends BaseEntity {
    @Column(nullable = false, unique = true)
    private String name;
    private String description;
    private String type;
    private String owner;

    @ManyToOne
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
