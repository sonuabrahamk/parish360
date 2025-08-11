package org.parish360.core.family.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SacramentInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;

    @NotNull(message = "sacrament type is not mentioned")
    private String type;

    @NotNull(message = "date is not mentioned")
    private LocalDate date;
    private String priest;
    private String parish;
    private Address place;
    private String memberId;
}
