package org.parish360.core.ceremonies.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;
import org.parish360.core.common.dto.GodParent;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SpouseInfo {
    private String spouseName;
    private String spouseBaptismName;
    private String spouseFather;
    private String spouseMother;
    private String spouseMaritalStatus;
    private LocalDate spouseDob;
    private String spouseContact;
    private String spouseEmail;
    private String spouseAddress;
    private GodParent godFather;
    private GodParent godMother;
    private Address birthPlace;
    private ChurchInfo spouseChurch;
}
