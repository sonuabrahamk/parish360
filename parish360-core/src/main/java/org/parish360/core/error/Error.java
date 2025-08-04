package org.parish360.core.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Error {
    private String error;
    private String message;
    private List<Map<String, String>> validations = new ArrayList<>();
    private int status;
    private LocalDateTime timestamp;
    private String path;
}
