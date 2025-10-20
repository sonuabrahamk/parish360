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
public class OrdinationInfo {
    private String religiousOrder;
    private String seminaryName;
    private Address seminaryAddress;
    private String previousOrdinationType;
    private LocalDate previousOrdinationDate;
    private Address previousOrdinationPlace;
}
