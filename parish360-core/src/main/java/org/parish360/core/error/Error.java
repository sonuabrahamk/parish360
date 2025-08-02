package org.parish360.core.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Error {
    private String error;
    private String message;
    private int status;
    private LocalDateTime timestamp;
    private String path;
}
