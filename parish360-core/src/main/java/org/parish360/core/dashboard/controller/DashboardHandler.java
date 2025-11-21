package org.parish360.core.dashboard.controller;

import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.dto.StatementResponse;
import org.parish360.core.dashboard.service.DashboardManager;
import org.parish360.core.family.dto.MemberInfo;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
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

    @GetMapping("/account-statement")
    ResponseEntity<List<StatementResponse>> getAccountStatement(@PathVariable("parishId") String parishId,
                                                                @RequestParam(value = "startDate", required = false)
                                                                @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                LocalDate startDate,
                                                                @RequestParam(value = "endDate", required = false)
                                                                @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                LocalDate endDate) {
        return ResponseEntity.ok(dashboardManager.getAccountStatement(parishId, startDate, endDate));
    }
}
