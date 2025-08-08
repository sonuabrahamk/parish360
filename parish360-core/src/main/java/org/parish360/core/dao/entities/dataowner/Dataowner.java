package org.parish360.core.dao.entities.dataowner;

import jakarta.persistence.*;
import lombok.Data;

import java.util.UUID;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "type")
public class Dataowner {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
}
