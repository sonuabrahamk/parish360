package org.parish360.core.configurations.service.impl;

import org.parish360.core.common.enums.ServiceRecurrencePattern;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.configurations.dto.ServiceInfo;
import org.parish360.core.configurations.dto.ServiceRequest;
import org.parish360.core.configurations.dto.ServiceResponse;
import org.parish360.core.configurations.service.ConfigurationMapper;
import org.parish360.core.configurations.service.ServiceManager;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.configurations.Services;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.configurations.ResourceRepository;
import org.parish360.core.dao.repository.configurations.ServiceRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ServiceManagerImpl implements ServiceManager {
    private final ConfigurationMapper configurationMapper;
    private final ServiceRepository serviceRepository;
    private final ResourceRepository resourceRepository;
    private final ParishRepository parishRepository;

    public ServiceManagerImpl(ConfigurationMapper configurationMapper, ServiceRepository serviceRepository, ParishRepository parishRepository, ResourceRepository resourceRepository, ParishRepository parishRepository1) {
        this.configurationMapper = configurationMapper;
        this.serviceRepository = serviceRepository;
        this.resourceRepository = resourceRepository;
        this.parishRepository = parishRepository1;
    }

    @Override
    @Transactional
    public ServiceResponse createServiceInfo(String parishId, ServiceRequest serviceRequest) {
        //validate resource information
        Resource resource = resourceRepository
                .findByIdAndParishId(UUIDUtil.decode(serviceRequest.getResourceId()), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find resource information"));

        //fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));

        List<Services> servicesToCreate = new ArrayList<>();
        List<Services> servicesToReject = new ArrayList<>();
        if (serviceRequest.isRecurring()) {
            // find the service dates
            List<LocalDate> serviceDates = generateServiceDates(serviceRequest.getStartDate(),
                    serviceRequest.getEndDate(),
                    serviceRequest.getServiceRecurrencePattern(),
                    serviceRequest.getDaysOfWeek());

            serviceDates.forEach(serviceDate -> {
                Services service = createService(serviceRequest, parish, resource);
                service.setDate(serviceDate);
                if (!serviceRepository.existsByResourceAndDateAndTime(resource.getId(),
                        serviceDate, serviceRequest.getStartTime(), serviceRequest.getEndTime())) {
                    servicesToCreate.add(service);
                } else {
                    servicesToReject.add(service);
                }
            });
        } else {
            Services service = createService(serviceRequest, parish, resource);
            service.setDate(serviceRequest.getStartDate());
            service.setStartTime(serviceRequest.getStartTime());
            service.setEndTime(serviceRequest.getEndTime());

            if (!serviceRepository.existsByResourceAndDateAndTime(resource.getId(),
                    serviceRequest.getStartDate(), serviceRequest.getStartTime(), serviceRequest.getEndTime())) {
                servicesToCreate.add(service);
            } else {
                servicesToReject.add(service);
            }
        }

        if (servicesToCreate.isEmpty()) {
            throw new BadRequestException("invalid / duplicate service creation request");
        }

        // save all services
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setServicesCreated(
                serviceRepository.saveAll(servicesToCreate)
                        .stream()
                        .map(configurationMapper::daoToServiceInfo)
                        .toList());
        serviceResponse.setServicesRejected(servicesToReject
                .stream()
                .map(configurationMapper::daoToServiceInfo)
                .toList());

        if (servicesToReject.isEmpty()) {
            serviceResponse.setStatus(HttpStatus.OK);
            return serviceResponse;
        }
        serviceResponse.setStatus(HttpStatus.PARTIAL_CONTENT);
        return serviceResponse;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ServiceInfo> getListOfServices(String parishId) {
        List<Services> services = serviceRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find service information"));
        return services.stream()
                .map(configurationMapper::daoToServiceInfo)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public ServiceInfo getService(String parishId, String serviceId) {
        return configurationMapper
                .daoToServiceInfo(serviceRepository
                        .findByIdAndParishId(UUIDUtil.decode(serviceId), UUIDUtil.decode(parishId))
                        .orElseThrow(() -> new ResourceNotFoundException("coiuld not find service information")));
    }

    // method to create a Service
    private Services createService(ServiceRequest serviceRequest, Parish parish, Resource resource) {
        Services service = new Services();
        service.setName(serviceRequest.getName());
        service.setType(serviceRequest.getType());
        service.setStartTime(serviceRequest.getStartTime());
        service.setEndTime(serviceRequest.getEndTime());
        service.setAmount(serviceRequest.getAmount());
        service.setCurrency(serviceRequest.getCurrency());
        service.setConversionRate(BigDecimal.ONE);
        service.setResource(resource);
        service.setParish(parish);
        return service;
    }

    // method to find the recurring dates
    private List<LocalDate> generateServiceDates(LocalDate startDate,
                                                 LocalDate endDate,
                                                 ServiceRecurrencePattern pattern,
                                                 List<DayOfWeek> daysOfWeek) {
        List<LocalDate> result = new ArrayList<>();

        LocalDate current = startDate;

        switch (pattern) {
            case DAILY:
                while (!current.isAfter(endDate)) {
                    result.add(current);
                    current = current.plusDays(1);
                }
                break;

            case WEEKLY:
                if (daysOfWeek == null || daysOfWeek.isEmpty()) {
                    throw new IllegalArgumentException("For WEEKLY recurrence, at least one day of week must be provided");
                }

                while (!current.isAfter(endDate)) {
                    if (daysOfWeek.contains(current.getDayOfWeek())) {
                        result.add(current);
                    }
                    current = current.plusDays(1);
                }
                break;

            case MONTHLY:
                while (!current.isAfter(endDate)) {
                    result.add(current);
                    current = current.plusMonths(1);
                }
                break;

            case YEARLY:
                while (!current.isAfter(endDate)) {
                    result.add(current);
                    current = current.plusYears(1);
                }
                break;
        }

        return result;
    }
}
