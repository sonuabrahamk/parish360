package org.parish360.core.dao.entities.dataowner;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Diocese extends Dataowner {

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
