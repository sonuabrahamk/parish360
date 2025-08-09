package org.parish360.core.dao.entities.associations;

import jakarta.persistence.*;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.family.Member;

@Entity
@Table(name = "committee_members")
public class CommitteeMember extends BaseEntity {

    @Column(nullable = false)
    private String designation;

    private int position;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "member_id")
    private Member memberDetails;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "association_id")
    private Association associationId;
}
