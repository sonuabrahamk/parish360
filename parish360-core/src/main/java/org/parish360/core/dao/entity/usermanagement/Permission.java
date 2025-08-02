package org.parish360.core.dao.entity.usermanagement;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.parish360.core.util.enums.PermissionType;

import java.util.UUID;

@Entity
@Table(name = "permissions")
@Getter
@NoArgsConstructor
@AllArgsConstructor
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
    @Enumerated(EnumType.STRING)
    private PermissionType permission;
}
