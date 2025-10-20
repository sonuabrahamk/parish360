package org.parish360.core.ceremonies.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.dao.entities.common.Address;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChurchInfo {
    private String familyCode;
    private String church;
    private String diocese;
    private Address churchLocation;
}
