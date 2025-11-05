package org.parish360.core.dao.entities.bookings;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.configurations.Services;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "bookings")
public class Booking extends BaseEntity {
    @Column(name = "booking_code", nullable = false)
    private String bookingCode;
    @Column(name = "booking_type", nullable = false)
    private String bookingType;
    @Column(name = "booked_by", nullable = false)
    private String bookedBy;
    @Column(name = "booked_from", nullable = false)
    private Instant bookedFrom;
    @Column(name = "booked_to", nullable = false)
    private Instant bookedTo;
    private String contact;
    private String description;
    private String event;
    private String status;

    @Column(name = "total_amount")
    private BigDecimal totalAmount;
    @Column(name = "amount_paid")
    private BigDecimal amountPaid;
    private String currency;
    @Column(name = "conversion_rate")
    private BigDecimal conversionRate;

    @ManyToOne
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private Services service;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;

    @ManyToOne
    @JoinColumn(name = "parish_id", nullable = false)
    private Parish parish;
}
