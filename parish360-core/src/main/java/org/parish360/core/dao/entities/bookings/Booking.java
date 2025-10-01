package org.parish360.core.dao.entities.bookings;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "bookings")
public class Booking extends BaseEntity {
    @Column(nullable = false)
    private String bookedBy;
    @Column(name = "booked_from", nullable = false)
    private LocalDateTime bookedFrom;
    @Column(name = "booked_to", nullable = false)
    private LocalDateTime bookedTo;
    private String contact;
    private String description;
    private String event;
    private String status;

    @ManyToOne
    @JoinColumn(name = "resource_id", nullable = false)
    private Resource resource;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;

    @ManyToOne
    @JoinColumn(name = "parish_id", nullable = false)
    private Parish parish;
}
