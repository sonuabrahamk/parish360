package org.parish360.core.family.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FamilyInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "family code is empty")
    private String familyCode;

    private String familyName;

    @NotNull(message = "contact is empty")
    private String contact;
    
    private String address;
    private boolean contactVerified;
    private LocalDate joinedDate;
    private String parishId;
}
