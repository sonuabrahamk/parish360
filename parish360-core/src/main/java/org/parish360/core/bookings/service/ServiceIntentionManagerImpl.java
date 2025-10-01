package org.parish360.core.bookings.service;

import org.parish360.core.bookings.dto.ServiceIntentionInfo;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.bookings.ServiceIntention;
import org.parish360.core.dao.entities.configurations.Services;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.bookings.BookingRepository;
import org.parish360.core.dao.repository.bookings.ServiceIntentionRepository;
import org.parish360.core.dao.repository.configurations.ServiceRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ServiceIntentionManagerImpl implements ServiceIntentionManager {
    private final BookingMapper bookingMapper;
    private final ParishRepository parishRepository;
    private final ServiceRepository serviceRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final ServiceIntentionRepository serviceIntentionRepository;

    public ServiceIntentionManagerImpl(BookingMapper bookingMapper, ParishRepository parishRepository, ServiceRepository serviceRepository, FamilyInfoRepository familyInfoRepository, BookingRepository bookingRepository, ServiceIntentionRepository serviceIntentionRepository) {
        this.bookingMapper = bookingMapper;
        this.parishRepository = parishRepository;
        this.serviceRepository = serviceRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.serviceIntentionRepository = serviceIntentionRepository;
    }

    @Override
    @Transactional
    public ServiceIntentionInfo createServiceIntention(String parishId, ServiceIntentionInfo serviceIntentionInfo) {
        ServiceIntention serviceIntention = bookingMapper.serviceIntentionsToDao(serviceIntentionInfo);

        // fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        serviceIntention.setParish(parish);

        // fetch service information
        Services services = serviceRepository
                .findById(UUIDUtil.decode(serviceIntentionInfo.getServiceId()))
                .orElseThrow(() -> new ResourceNotFoundException("could not find service information"));
        serviceIntention.setService(services);

        if (!serviceIntentionInfo.getFamilyCode().isEmpty()) {
            Family family = familyInfoRepository
                    .findByFamilyCodeAndParishId(serviceIntentionInfo.getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not find family information"));
            serviceIntention.setFamily(family);
        }

        return bookingMapper.daoToServiceIntentions(serviceIntentionRepository.save(serviceIntention));
    }

    @Override
    @Transactional
    public ServiceIntentionInfo updateServiceIntention(String parishId,
                                                       String serviceIntentionId,
                                                       ServiceIntentionInfo serviceIntentionInfo) {
        // fetch current serviceIntention
        ServiceIntention currentServiceIntention = serviceIntentionRepository
                .findByIdAndParishId(UUIDUtil.decode(serviceIntentionId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not fine service intention information"));

        ServiceIntention updateServiceIntention = bookingMapper.serviceIntentionsToDao(serviceIntentionInfo);
        bookingMapper.mergeNotNullServiceIntentions(updateServiceIntention, currentServiceIntention);

        return bookingMapper.daoToServiceIntentions(serviceIntentionRepository.save(currentServiceIntention));
    }

    @Override
    @Transactional(readOnly = true)
    public ServiceIntentionInfo getServiceIntentionsInfo(String parishId, String serviceIntentionId) {
        return bookingMapper.daoToServiceIntentions(serviceIntentionRepository
                .findByIdAndParishId(UUIDUtil.decode(serviceIntentionId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find service intention information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<ServiceIntentionInfo> getListOfServiceIntentions(String parishId) {
        List<ServiceIntention> serviceIntentions = serviceIntentionRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find service intentions information"));

        return serviceIntentions.stream()
                .map(bookingMapper::daoToServiceIntentions)
                .toList();
    }

    @Override
    @Transactional
    public void deleteServiceIntentionInfo(String parishId, String serviceIntentionId) {
        ServiceIntention serviceIntention = serviceIntentionRepository
                .findByIdAndParishId(UUIDUtil.decode(serviceIntentionId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find service intention information"));

        serviceIntentionRepository.delete(serviceIntention);
    }
}
