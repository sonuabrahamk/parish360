package org.parish360.core.dao.entities.family;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;
import org.parish360.core.dao.entities.common.BaseEntity;
import org.parish360.core.dao.entities.common.GodParent;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "members")
public class Member extends BaseEntity {
    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "baptism_name")
    private String baptismName;

    private String email;

    @Column(nullable = false)
    private String contact;

    @Column(name = "contact_verified")
    private boolean contactVerified;

    @Column(name = "marital_status")
    private String maritalStatus;

    private LocalDate dob;
    private String gender;
    private String father;
    private String mother;
    private String qualification;
    private String occupation;
    private String relationship;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "godfather_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "godfather_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "godfather_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "godfather_contact")),
    })
    private GodParent godFather;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "name", column = @Column(name = "godmother_name")),
            @AttributeOverride(name = "parish", column = @Column(name = "godmother_parish")),
            @AttributeOverride(name = "baptismName", column = @Column(name = "godmother_baptism_name")),
            @AttributeOverride(name = "contact", column = @Column(name = "godmother_contact")),
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

    @ManyToOne
    @JoinColumn(name = "family_id")
    private Family family;
}
