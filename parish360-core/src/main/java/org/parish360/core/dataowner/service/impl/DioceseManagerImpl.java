package org.parish360.core.dataowner.service.impl;

import org.parish360.core.common.util.AuthUtil;
import org.parish360.core.dao.entities.dataowner.Diocese;
import org.parish360.core.dao.repository.dataowner.DioceseRepository;
import org.parish360.core.dataowner.dto.DioceseInfo;
import org.parish360.core.dataowner.service.DataownerMapper;
import org.parish360.core.dataowner.service.DioceseManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DioceseManagerImpl implements DioceseManager {

    private final DataownerMapper dataownerMapper;

    private final DioceseRepository dioceseRepository;

    public DioceseManagerImpl(DataownerMapper dataownerMapper, DioceseRepository dioceseRepository) {
        this.dataownerMapper = dataownerMapper;
        this.dioceseRepository = dioceseRepository;
    }

    @Override
    @Transactional
    public DioceseInfo createDiocese(DioceseInfo dioceseInfo) {
        Diocese diocese = dataownerMapper.dioceseInfoToDao(dioceseInfo);
        diocese.setCreatedBy(AuthUtil.getCurrentUserId());
        diocese.setCreatedAt(Instant.now());
        return dataownerMapper.daoToDioceseInfo(dioceseRepository.save(diocese));
    }

    @Override
    @Transactional
    public List<DioceseInfo> getDiocese() {
        return dioceseRepository.findAll().stream()
                .map(dataownerMapper::daoToDioceseInfo)
                .collect(Collectors.toList());
    }
}
