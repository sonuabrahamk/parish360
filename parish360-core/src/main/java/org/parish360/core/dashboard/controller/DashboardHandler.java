package org.parish360.core.dashboard.controller;

import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.service.DashboardManager;
import org.parish360.core.family.dto.MemberInfo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/dashboard")
public class DashboardHandler {
    private final DashboardManager dashboardManager;

    public DashboardHandler(DashboardManager dashboardManager) {
        this.dashboardManager = dashboardManager;
    }

    @GetMapping
    ResponseEntity<ParishReportInfo> getParishReport(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(dashboardManager.getParishReport(parishId));
    }

    @GetMapping("/members")
    ResponseEntity<List<MemberInfo>> getMemberList(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(dashboardManager.getAllMembers(parishId));
    }
}
