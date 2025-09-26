package org.parish360.core.dao.entities.associations;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.BaseEntity;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "committee_members")
public class CommitteeMember extends BaseEntity {

    @Column(nullable = false)
    private String designation;

    private int position;

    @Column(nullable = false)
    private String name;

    private String contact;
    private String email;

    @ManyToOne
    @JoinColumn(name = "py_association_id")
    private ParishYearAssociation parishYearAssociation;
}
