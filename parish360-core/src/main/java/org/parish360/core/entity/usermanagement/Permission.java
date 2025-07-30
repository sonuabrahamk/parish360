package org.parish360.core.entity.usermanagement;

import jakarta.persistence.*;
import lombok.Data;

import java.util.UUID;

@Entity
@Table(name = "permissions")
@Data
public class Permission {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(unique = true, nullable = false)
    private String name;

    @Column
    private String description;

    @Column(nullable = false)
    private String module;

    @Column(nullable = false)
    private String permission;
}
