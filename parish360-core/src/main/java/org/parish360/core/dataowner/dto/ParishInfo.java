package org.parish360.core.dataowner.dto;

import jakarta.validation.constraints.Email;
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
public class ParishInfo {
    private String id;
    private Instant createdAt;
    private String createdBy;
    private Instant updatedAt;
    private String updatedBy;
    @NotNull(message = "parish name is empty")
    private String name;
    private String denomination;
    private String patron;
    private String contact;
    @Email(message = "email is not valid")
    private String email;
    private LocalDate foundedDate;
    private Boolean isActive;
    private String website;
    private String locale;
    private String timezone;
    private Address address;
}
