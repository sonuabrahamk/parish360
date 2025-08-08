package org.parish360.core.dao.entities.dataowner;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;

import java.time.Instant;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Forane extends Dataowner {

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
    private String website;

    @Column
    private String locale;

    @Column
    private String timezone;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id", nullable = true)
    private Address address;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "diocese_id", nullable = false)
    private Diocese diocese;
}
