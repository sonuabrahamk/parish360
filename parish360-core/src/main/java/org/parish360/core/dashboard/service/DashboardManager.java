package org.parish360.core.dashboard.service;

import org.parish360.core.dashboard.dto.ParishReportInfo;

public interface DashboardManager {
    ParishReportInfo getParishReport(String parishId);
}
