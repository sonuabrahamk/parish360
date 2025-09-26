package org.parish360.core.configurations.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PYAssociationResponse {
    private String id;
    private ParishYearInfo parishYear;
    private AssociationInfo association;
}
