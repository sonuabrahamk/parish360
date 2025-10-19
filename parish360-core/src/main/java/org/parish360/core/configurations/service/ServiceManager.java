package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.ServiceInfo;
import org.parish360.core.configurations.dto.ServiceRequest;
import org.parish360.core.configurations.dto.ServiceResponse;

import java.time.LocalDate;
import java.util.List;

public interface ServiceManager {
    ServiceResponse createServiceInfo(String parishId, ServiceRequest serviceRequest);

    List<ServiceInfo> getListOfServices(String parishId, LocalDate startDate, LocalDate endDate);

    ServiceInfo getService(String parishId, String serviceId);
}
