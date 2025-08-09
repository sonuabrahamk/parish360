package org.parish360.core.dao.entities.family;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;
import org.parish360.core.dao.entities.common.BaseEntity;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "migrations")
public class Migration extends BaseEntity {

    @Column(name = "migrated_on")
    private LocalDate migratedOn;

    @Column(name = "return_date")
    private LocalDate returnDate;

    private String comment;

    @Embedded
    private Address place;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;
}
