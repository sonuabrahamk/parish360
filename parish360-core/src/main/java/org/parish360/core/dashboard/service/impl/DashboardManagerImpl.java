package org.parish360.core.dashboard.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.service.DashboardManager;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DashboardManagerImpl implements DashboardManager {
    private final ParishRepository parishRepository;

    public DashboardManagerImpl(ParishRepository parishRepository) {
        this.parishRepository = parishRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public ParishReportInfo getParishReport(String parishId) {
        return parishRepository
                .findParishReport(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish report"));
    }
}
