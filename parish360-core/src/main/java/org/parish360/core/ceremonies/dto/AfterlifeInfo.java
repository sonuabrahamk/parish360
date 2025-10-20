package org.parish360.core.ceremonies.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AfterlifeInfo {
    private String cemetery;
    private LocalDate dod;
    private Address cemeteryPlace;
    private Address placeOfDeath;
}
