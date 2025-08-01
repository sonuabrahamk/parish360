package org.parish360.core.dao.entity.dataowner;

import jakarta.persistence.*;
import lombok.Data;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Data
@Entity
public class Diocese {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(name = "created_at")
    private Instant createdAt;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "updated_at")
    private Instant updatedAt;

    @Column(name = "updated_by")
    private String updatedBy;

    @Column(nullable = false)
    private String name;

    @Column
    private String denomination;

    @Column
    private String patron;

    @Column
    private String contact;

    @Column
    private String email;

    @Column(name = "founded_date")
    private LocalDate foundedDate;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column
    private String location;

    @Column
    private String city;

    @Column
    private String state;

    @Column
    private String country;

    @Column
    private String website;

    @Column
    private String locale;

    @Column
    private String timezone;
}
