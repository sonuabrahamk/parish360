package org.parish360.core.family.controller;

import jakarta.validation.Valid;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.family.dto.SubscriptionInfo;
import org.parish360.core.family.service.SubscriptionManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/family-records/{familyId}/subscriptions")
public class SubscriptionHandler {
    private final SubscriptionManager subscriptionManager;

    public SubscriptionHandler(SubscriptionManager subscriptionManager) {
        this.subscriptionManager = subscriptionManager;
    }

    @PostMapping
    ResponseEntity<SubscriptionInfo> createSubscription(
            @PathVariable("parishId") String parishId,
            @PathVariable("familyId") String familyId,
            @Valid @RequestBody SubscriptionInfo subscriptionInfo) {
        return ResponseEntity.ok(
                subscriptionManager.createSubscription(parishId, familyId, subscriptionInfo));
    }

    @PatchMapping("/{subscriptionId}")
    ResponseEntity<SubscriptionInfo> updateSubscription(
            @PathVariable("familyId") String familyId,
            @PathVariable("subscriptionId") String subscriptionId,
            @Valid @RequestBody SubscriptionInfo subscriptionInfo) {
        //validate subscription ID
        if (subscriptionInfo.getFamilyId() != null && !subscriptionInfo.getFamilyId().equals(subscriptionId)) {
            throw new BadRequestException("subscription information mismatch");
        }

        return ResponseEntity.ok(
                subscriptionManager.updateSubscription(familyId, subscriptionId, subscriptionInfo));
    }

    @GetMapping
    ResponseEntity<List<SubscriptionInfo>> getSubscriptionList(
            @PathVariable("familyId") String familyId) {
        return ResponseEntity.ok(subscriptionManager.getSubscriptionList(familyId));
    }

    @GetMapping("/{subscriptionId}")
    ResponseEntity<SubscriptionInfo> getSubscription(
            @PathVariable("familyId") String familyId,
            @PathVariable("subscriptionId") String subscriptionId) {
        return ResponseEntity.ok(subscriptionManager.getSubscription(familyId, subscriptionId));
    }

    @DeleteMapping("/{subscriptionId}")
    ResponseEntity<SubscriptionInfo> deleteSubscription(
            @PathVariable("familyId") String familyId,
            @PathVariable("subscriptionId") String subscriptionId) {
        subscriptionManager.deleteSubscription(familyId, subscriptionId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
