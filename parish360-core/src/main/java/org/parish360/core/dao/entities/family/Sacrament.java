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
@Table(name = "sacraments")
public class Sacrament extends BaseEntity {
    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private LocalDate date;
    
    private String priest;
    private String parish;

    @Embedded
    private Address place;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;
}
