package org.parish360.core.associations.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AssociateInfo {
    private String id;
    private String associationId;
    private String associatesId;
}
