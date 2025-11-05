package org.parish360.core.family.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MiscellaneousInfo {
    private String id;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;

    @NotNull(message = "comment by is not specified")
    private String commentedBy;

    @NotNull(message = "comment is not specified")
    private String comment;

    private String familyId;
}
