package org.parish360.core.dao.entities.ceremonies;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class Church {
    @Column(name = "family_code")
    private String familyCode;
    private String church;
    private String diocese;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "church_location")),
            @AttributeOverride(name = "city", column = @Column(name = "church_city")),
            @AttributeOverride(name = "state", column = @Column(name = "church_state")),
            @AttributeOverride(name = "country", column = @Column(name = "church_country")),
    })
    private Address churchLocation;
}
