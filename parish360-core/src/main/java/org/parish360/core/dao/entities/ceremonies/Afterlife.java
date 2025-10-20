package org.parish360.core.dao.entities.ceremonies;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class Afterlife {
    private String cemetery;
    private LocalDate dod;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "cemetery_location")),
            @AttributeOverride(name = "city", column = @Column(name = "cemetery_city")),
            @AttributeOverride(name = "state", column = @Column(name = "cemetery_state")),
            @AttributeOverride(name = "country", column = @Column(name = "cemetery_country")),
    })
    private Address cemeteryPlace;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "pod_location")),
            @AttributeOverride(name = "city", column = @Column(name = "pod_city")),
            @AttributeOverride(name = "state", column = @Column(name = "pod_state")),
            @AttributeOverride(name = "country", column = @Column(name = "pod_country")),
    })
    private Address placeOfDeath;
}
