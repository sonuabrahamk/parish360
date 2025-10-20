package org.parish360.core.ceremonies.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;
import org.parish360.core.common.dto.GodParent;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CeremonyInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotBlank(message = "ceremony type has to be specified")
    private String type;

    @NotNull(message = "ceremony date has to be specified")
    private LocalDate date;

    private Boolean isParishioner = false;
    private MinisterInfo minister;
    private ChurchInfo church;
    private String name;
    private String baptismName;
    private String father;
    private String mother;
    private LocalDate dob;
    private String maritalStatus;
    private String email;
    private String contact;
    private String address;
    private String remarks;
    private GodParent godFather;
    private GodParent godMother;
    private Address birthPlace;
    private SpouseInfo spouse;
    private WitnessInfo witness1;
    private WitnessInfo witness2;
    private OrdinationInfo ordination;
    private AfterlifeInfo afterlife;
    private String family_id;
    private String parish_id;
}
