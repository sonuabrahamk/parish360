package org.parish360.core.configurations.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.AssociationType;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AssociationInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "association name is not specified")
    private String name;

    private String description;
    private AssociationType type;
    private String director;
    private String scope;
    private String patron;
    private LocalDate foundedDate;
    private boolean isActive;
    private String parishId;
}
