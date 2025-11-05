package org.parish360.core.configurations.dto;

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
public class AccountInfo {
    private String id;
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;

    @NotNull(message = "account name is not mentioned")
    private String name;
    private String description;
    private String type;
    private String owner;
    private String bankName;
    private String accountNumber;
    private String branch;
    private String ifscCode;
    private String parishId;
}
