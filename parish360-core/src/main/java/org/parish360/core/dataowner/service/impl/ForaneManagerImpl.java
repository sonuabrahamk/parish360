package org.parish360.core.dataowner.service.impl;

import org.parish360.core.common.util.AuthUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.dataowner.Diocese;
import org.parish360.core.dao.entities.dataowner.Forane;
import org.parish360.core.dao.repository.dataowner.DioceseRepository;
import org.parish360.core.dao.repository.dataowner.ForaneRepository;
import org.parish360.core.dataowner.dto.ForaneInfo;
import org.parish360.core.dataowner.service.DataownerMapper;
import org.parish360.core.dataowner.service.ForaneManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ForaneManagerImpl implements ForaneManager {
    private final DioceseRepository dioceseRepository;
    private final ForaneRepository foraneRepository;
    private final DataownerMapper dataownerMapper;

    public ForaneManagerImpl(DioceseRepository dioceseRepository, ForaneRepository foraneRepository, DataownerMapper dataownerMapper) {
        this.dioceseRepository = dioceseRepository;
        this.foraneRepository = foraneRepository;
        this.dataownerMapper = dataownerMapper;
    }

    @Override
    @Transactional
    public List<ForaneInfo> getForaneList(String dioceseId) {
        return foraneRepository.findAll().stream()
                .map(dataownerMapper::daoToForaneInfo)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public ForaneInfo createForane(String dioceseId, ForaneInfo foraneInfo) {

        Diocese diocese = dioceseRepository.findById(UUIDUtil.decode(dioceseId))
                .orElseThrow(() -> new BadRequestException("could not find diocese id"));

        Forane forane = dataownerMapper.foraneInfoToDao(foraneInfo);
        forane.setCreatedBy(AuthUtil.getCurrentUserId());
        forane.setCreatedAt(Instant.now());
        forane.setDiocese(diocese);

        return dataownerMapper.daoToForaneInfo(foraneRepository.save(forane));
    }
}
