package org.parish360.core.dashboard.service;

import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.family.dto.MemberInfo;

import java.util.List;

public interface DashboardManager {
    ParishReportInfo getParishReport(String parishId);

    List<MemberInfo> getAllMembers(String parishId);
}
