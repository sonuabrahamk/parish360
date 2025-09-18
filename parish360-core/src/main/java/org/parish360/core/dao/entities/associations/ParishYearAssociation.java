package org.parish360.core.dao.entities.associations;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.configurations.ParishYear;

import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "parish_year_associations")
public class ParishYearAssociation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "parish_year_id")
    private ParishYear parishYear;

    @ManyToOne
    @JoinColumn(name = "association_id")
    private Association association;
}
