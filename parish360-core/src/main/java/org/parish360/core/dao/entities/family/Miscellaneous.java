package org.parish360.core.dao.entities.family;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
public class Miscellaneous extends BaseEntity {
    @Column(name = "commented_by")
    private String commentedBy;
    private String comment;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;
}
