package org.parish360.core.family.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.dto.Address;
import org.parish360.core.common.dto.GodParent;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberInfo {
    private String id;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;

    @NotNull(message = "firstname is empty")
    private String firstName;

    private String lastName;
    private String baptismName;
    private String email;

    @NotNull(message = "contact is empty")
    private String contact;

    private boolean contactVerified;
    private String maritalStatus;
    private LocalDate dob;
    private String gender;
    private String father;
    private String mother;
    private String qualification;
    private String occupation;
    private String relationship;
    private GodParent godFather;
    private GodParent godMother;
    private Address birthPlace;
    private String familyId;
}
