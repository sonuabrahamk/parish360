package org.parish360.core.dto.error;

import lombok.Data;

@Data
public class ErrorResponse {
    private int code;
    private String message;
}
