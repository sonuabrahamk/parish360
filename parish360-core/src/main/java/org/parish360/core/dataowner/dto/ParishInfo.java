package org.parish360.core.dataowner.dto;

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
    private String email;
    private LocalDate foundedDate;
    private Boolean isActive;
    private String location;
    private String city;
    private String state;
    private String country;
    private String website;
    private String locale;
    private String timezone;
}
