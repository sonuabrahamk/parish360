package org.parish360.core.ceremonies.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WitnessInfo {
    private String name;
    private String relation;
    private String parish;
    private String contact;
}
