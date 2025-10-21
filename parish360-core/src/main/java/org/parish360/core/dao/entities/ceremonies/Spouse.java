package org.parish360.core.dao.entities.ceremonies;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;
import org.parish360.core.dao.entities.common.GodParent;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class Spouse {
    @Column(name = "spouse_name")
    private String spouseName;
    @Column(name = "spouse_baptism_name")
    private String spouseBaptismName;
    @Column(name = "spouse_father")
    private String spouseFather;
    @Column(name = "spouse_mother")
    private String spouseMother;
    @Column(name = "spouse_marital_status")
    private String spouseMaritalStatus;
    @Column(name = "spouse_dob")
    private LocalDate spouseDob;
    @Column(name = "spouse_contact")
    private String spouseContact;
    @Column(name = "spouse_email")
    private String spouseEmail;
    @Column(name = "spouse_address")
    private String spouseAddress;
    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "spouse_god_father_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "spouse_god_father_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "spouse_god_father_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "spouse_god_father_contact")),
    })
    private GodParent godFather;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "spouse_god_mother_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "spouse_god_mother_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "spouse_god_mother_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "spouse_god_mother_contact")),
    })
    private GodParent godMother;


    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "spouse_birth_location")),
            @AttributeOverride(name = "city", column = @Column(name = "spouse_birth_city")),
            @AttributeOverride(name = "state", column = @Column(name = "spouse_birth_state")),
            @AttributeOverride(name = "country", column = @Column(name = "spouse_birth_country")),
    })
    private Address birthPlace;


    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "familyCode", column = @Column(name = "spouse_family_code")),
            @AttributeOverride(name = "church", column = @Column(name = "spouse_church")),
            @AttributeOverride(name = "diocese", column = @Column(name = "spouse_diocese")),
            @AttributeOverride(name = "churchLocation", column = @Column(name = "spouse_church_location")),
    })
    private Church spouseChurch;

}
