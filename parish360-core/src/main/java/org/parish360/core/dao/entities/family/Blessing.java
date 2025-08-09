package org.parish360.core.dao.entities.family;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "blessings")
public class Blessing extends BaseEntity {
    private String priest;
    private LocalDate date;
    private String reason;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;
}
