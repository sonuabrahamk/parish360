package org.parish360.core.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ParishReportInfo {
    private Long numberOfAssociations;
    private Long numberOfUnits;
    private Long numberOfFamilies;
    private Long numberOfMembers;
}
