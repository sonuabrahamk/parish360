package org.parish360.core.bookings.controller;

import jakarta.validation.Valid;
import org.parish360.core.bookings.dto.ServiceIntentionInfo;
import org.parish360.core.bookings.service.ServiceIntentionManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/service-intentions")
public class ServiceIntentionHandler {
    private final ServiceIntentionManager serviceIntentionManager;

    public ServiceIntentionHandler(ServiceIntentionManager serviceIntentionManager) {
        this.serviceIntentionManager = serviceIntentionManager;
    }

    @PostMapping
    public ResponseEntity<ServiceIntentionInfo> createServiceIntentions(
            @PathVariable("parishId") String parishId,
            @Valid @RequestBody ServiceIntentionInfo serviceIntentionInfo) {
        return ResponseEntity.ok(serviceIntentionManager.createServiceIntention(parishId, serviceIntentionInfo));
    }

    @PatchMapping("/{serviceIntentionId}")
    public ResponseEntity<ServiceIntentionInfo> updateServiceIntentions(
            @PathVariable("parishId") String parishId,
            @PathVariable("serviceIntentionId") String serviceIntentionId,
            @Valid @RequestBody ServiceIntentionInfo serviceIntentionInfo) {
        return ResponseEntity.ok(serviceIntentionManager
                .updateServiceIntention(parishId, serviceIntentionId, serviceIntentionInfo));
    }

    @GetMapping("/{serviceIntentionId}")
    public ResponseEntity<ServiceIntentionInfo> getServiceIntentionInfo(
            @PathVariable("parishId") String parishId,
            @PathVariable("serviceIntentionId") String serviceIntentionId) {
        return ResponseEntity.ok(serviceIntentionManager
                .getServiceIntentionsInfo(parishId, serviceIntentionId));
    }

    @GetMapping
    public ResponseEntity<List<ServiceIntentionInfo>> getServiceIntentionInfo(
            @PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(serviceIntentionManager
                .getListOfServiceIntentions(parishId));
    }

    @DeleteMapping("/{serviceIntentionId}")
    public ResponseEntity<Object> deleteServiceIntentionInfo(
            @PathVariable("parishId") String parishId,
            @PathVariable("serviceIntentionId") String serviceIntentionId) {
        serviceIntentionManager.deleteServiceIntentionInfo(parishId, serviceIntentionId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
