package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.common.enums.ServiceRecurrencePattern;
import org.parish360.core.configurations.dto.ServiceInfo;
import org.parish360.core.configurations.dto.ServiceRequest;
import org.parish360.core.configurations.dto.ServiceResponse;
import org.parish360.core.configurations.service.ServiceManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/configurations/services")
public class ServiceHandler {
    private final ServiceManager serviceManager;

    public ServiceHandler(ServiceManager serviceManager) {
        this.serviceManager = serviceManager;
    }

    @PostMapping
    public ResponseEntity<ServiceResponse> createServiceInfo(@PathVariable("parishId") String parishId,
                                                             @Valid @RequestBody ServiceRequest serviceRequest) {
        //validate recurring information in request
        if (serviceRequest.isRecurring()) {
            if (serviceRequest.getStartDate().isAfter(serviceRequest.getEndDate())) {
                throw new BadRequestException("start date cannot be after the end date");
            }
            if (serviceRequest.getEndDate() == null || serviceRequest.getServiceRecurrencePattern() == null) {
                throw new BadRequestException(
                        "service occurrence pattern and end date cannot be null for recurring requests");
            }
            if (serviceRequest.getServiceRecurrencePattern() == ServiceRecurrencePattern.WEEKLY
                    && serviceRequest.getDaysOfWeek() == null) {
                throw new BadRequestException("days of the week has to be specified for weekly service requests");
            }
        }
        ServiceResponse serviceResponse = serviceManager.createServiceInfo(parishId, serviceRequest);
        return ResponseEntity.status(serviceResponse.getStatus()).body(serviceResponse);
    }

    @GetMapping
    public ResponseEntity<List<ServiceInfo>> getListOfServices(@PathVariable("parishId") String parishId,
                                                               @RequestParam(value = "startDate", required = false)
                                                               @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                               LocalDate startDate,
                                                               @RequestParam(value = "endDate", required = false)
                                                               @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                               LocalDate endDate) {
        return ResponseEntity.ok(serviceManager.getListOfServices(parishId, startDate, endDate));
    }

    @GetMapping("/{serviceId}")
    public ResponseEntity<ServiceInfo> getService(@PathVariable("parishId") String parishId,
                                                  @PathVariable("serviceId") String serviceId) {
        return ResponseEntity.ok(serviceManager.getService(parishId, serviceId));
    }

    @DeleteMapping("/{serviceId}")
    public ResponseEntity<Object> deleteService(@PathVariable("parishId") String parishId,
                                                @PathVariable("serviceId") String serviceId) {
        serviceManager.deleteService(parishId, serviceId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
