package org.parish360.core.dto.common;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Place {
    private String location;
    private String city;
    private String state;
    private String country;
}
