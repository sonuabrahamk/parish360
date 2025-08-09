package org.parish360.core.dao.entities.family;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.dataowner.Parish;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "families")
public class Family extends BaseEntity {

    @Column(name = "family_code", nullable = false, unique = true)
    private String familyCode;

    @Column(name = "family_name")
    private String familyName;

    private String contact;
    private String address;

    @Column(name = "contact_verified")
    private boolean contactVerified;

    @Column(name = "joined_date")
    private LocalDate joinedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
