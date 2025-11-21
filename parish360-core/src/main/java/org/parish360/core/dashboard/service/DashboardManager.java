package org.parish360.core.dashboard.service;

import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.dto.StatementResponse;
import org.parish360.core.family.dto.MemberInfo;

import java.time.LocalDate;
import java.util.List;

public interface DashboardManager {
    ParishReportInfo getParishReport(String parishId);

    List<MemberInfo> getAllMembers(String parishId);

    List<StatementResponse> getAccountStatement(String parishId, LocalDate startDate, LocalDate endDate);
}
