package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.ServiceInfo;
import org.parish360.core.configurations.dto.ServiceRequest;
import org.parish360.core.configurations.dto.ServiceResponse;

import java.util.List;

public interface ServiceManager {
    ServiceResponse createServiceInfo(String parishId, ServiceRequest serviceRequest);

    List<ServiceInfo> getListOfServices(String parishId);

    ServiceInfo getService(String parishId, String serviceId);
}
