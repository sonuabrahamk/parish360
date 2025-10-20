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
public class Ordination {
    @Column(name = "religious_order")
    private String religiousOrder;

    @Column(name = "seminary_name")
    private String seminaryName;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "seminary_location")),
            @AttributeOverride(name = "city", column = @Column(name = "seminary_city")),
            @AttributeOverride(name = "state", column = @Column(name = "seminary_state")),
            @AttributeOverride(name = "country", column = @Column(name = "seminary_country")),
    })
    private Address seminaryAddress;

    @Column(name = "previous_ordination_type")
    private String previousOrdinationType;

    @Column(name = "previous_ordination_date")
    private LocalDate previousOrdinationDate;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride(name = "location", column = @Column(name = "previous_ordination_location")),
            @AttributeOverride(name = "city", column = @Column(name = "previous_ordination_city")),
            @AttributeOverride(name = "state", column = @Column(name = "previous_ordination_state")),
            @AttributeOverride(name = "country", column = @Column(name = "previous_ordination_country")),
    })
    private Address previousOrdinationPlace;
}
