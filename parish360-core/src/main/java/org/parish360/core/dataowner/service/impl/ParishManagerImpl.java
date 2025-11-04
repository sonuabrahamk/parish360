package org.parish360.core.dataowner.service.impl;

import org.parish360.core.common.util.AuthUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Diocese;
import org.parish360.core.dao.entities.dataowner.Forane;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.repository.dataowner.DioceseRepository;
import org.parish360.core.dao.repository.dataowner.ForaneRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dataowner.dto.ParishInfo;
import org.parish360.core.dataowner.service.DataownerMapper;
import org.parish360.core.dataowner.service.ParishManager;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ParishManagerImpl implements ParishManager {
    private final DioceseRepository dioceseRepository;
    private final ForaneRepository foraneRepository;
    private final ParishRepository parishRepository;
    private final DataownerMapper dataownerMapper;

    public ParishManagerImpl(DioceseRepository dioceseRepository, ForaneRepository foraneRepository, ParishRepository parishRepository, DataownerMapper dataownerMapper) {
        this.dioceseRepository = dioceseRepository;
        this.foraneRepository = foraneRepository;
        this.parishRepository = parishRepository;
        this.dataownerMapper = dataownerMapper;
    }

    @Override
    @Transactional
    public List<ParishInfo> getParishList(String dioceseId, String foraneId) {
        return parishRepository.findAll().stream()
                .map(dataownerMapper::daoToParishInfo)
                .collect(Collectors.toList());
    }

    @Override
    public ParishInfo getParishInfo(String parishId) {
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not fetch parish information"));
        return dataownerMapper.daoToParishInfo(parish);
    }

    @Override
    public ParishInfo updateParishInfo(String parishId, ParishInfo parishInfo) {
        Parish currentParish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not fetch parish information"));

        Parish updateParish = dataownerMapper.parishInfoToDao(parishInfo);

        dataownerMapper.mergeNotNullParishInfo(updateParish, currentParish);

        return dataownerMapper.daoToParishInfo(parishRepository.save(currentParish));
    }

    @Override
    @Transactional
    public ParishInfo createParish(String dioceseId, String foraneId, ParishInfo parishInfo) {

        Diocese diocese = dioceseRepository.findById(UUIDUtil.decode(dioceseId))
                .orElseThrow(() -> new BadRequestException("diocese not found"));

        Forane forane = foraneRepository.findById(UUIDUtil.decode(foraneId))
                .orElseThrow(() -> new BadRequestException("forane not found"));

        Parish parish = dataownerMapper.parishInfoToDao(parishInfo);
        parish.setCreatedBy(AuthUtil.getCurrentUserId());
        parish.setCreatedAt(Instant.now());
        parish.setDiocese(diocese);
        parish.setForane(forane);

        return dataownerMapper.daoToParishInfo(parishRepository.save(parish));
    }
}
