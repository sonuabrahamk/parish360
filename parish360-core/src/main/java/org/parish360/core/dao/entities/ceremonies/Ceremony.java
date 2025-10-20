package org.parish360.core.dao.entities.ceremonies;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.common.GodParent;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ceremonies")
public class Ceremony extends BaseEntity {
    private String type;
    private LocalDate date;

    @Column(name = "is_parishioner")
    private Boolean isParishioner;

    @Embedded
    private Minister minister;

    @Embedded
    private Church church;

    private String name;
    @Column(name = "baptism_name")
    private String baptismName;
    private String father;
    private String mother;
    private LocalDate dob;
    @Column(name = "marital_status")
    private String maritalStatus;
    private String address;
    private String remarks;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "god_father_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "god_father_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "god_father_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "god_father_contact")),
    })
    private GodParent godFather;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "god_mother_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "god_mother_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "god_mother_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "god_mother_contact")),
    })
    private GodParent godMother;


    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "birth_location")),
            @AttributeOverride(name = "city", column = @Column(name = "birth_city")),
            @AttributeOverride(name = "state", column = @Column(name = "birth_state")),
            @AttributeOverride(name = "country", column = @Column(name = "birth_country")),
    })
    private Address birthPlace;

    @Embedded
    private Spouse spouse;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "witness1_name")),
            @AttributeOverride(name = "relation", column = @Column(name = "witness1_relation")),
            @AttributeOverride(name = "parish", column = @Column(name = "witness1_parish")),
            @AttributeOverride(name = "contact", column = @Column(name = "witness1_contact")),
    })
    private Witness witness1;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "witness2_name")),
            @AttributeOverride(name = "relation", column = @Column(name = "witness2_relation")),
            @AttributeOverride(name = "parish", column = @Column(name = "witness2_parish")),
            @AttributeOverride(name = "contact", column = @Column(name = "witness2_contact")),
    })
    private Witness witness2;

    @Embedded
    private Ordination ordination;

    @Embedded
    private Afterlife afterlife;

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;

    @ManyToOne
    @JoinColumn(name = "parish_id")
    private Parish parish;
}
