package org.parish360.core.entity.usermanagement;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "users")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "updated_by")
    private String updatedBy;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(unique = true, nullable = false)
    private String email;

    @Column
    private String password;

    @Column
    private String contact;

    @Column(name = "is_active", nullable = false)
    private Boolean active = true;

    @Column(name = "last_login")
    private Date lastLogin;

    @Column(name = "tou_accepted", nullable = false)
    private Boolean isTouAccepted = false;

    @Column(name = "reset_password", nullable = false)
    private Boolean isResetPassword = false;

    @Column
    private String comment;

    @Column(name = "entity_name", nullable = false)
    private String entityName;

    @Column(name = "entity_id", nullable = false)
    private UUID entityId;
}
