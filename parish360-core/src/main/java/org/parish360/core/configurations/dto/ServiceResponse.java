package org.parish360.core.configurations.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.http.HttpStatus;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ServiceResponse {
    private HttpStatus status;
    private String message;
    private List<ServiceInfo> servicesCreated;
    private List<ServiceInfo> servicesRejected;
}
