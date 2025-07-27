package org.parish360.core.dto.usermanagement;

import lombok.Data;

@Data
public class ErrorResponse {
    private int code;
    private String message;
}
