package org.parish360.core.associations.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AssociatesRequest {
    @NotNull(message = "at least one associate information has to be present")
    private List<String> associates;
}
