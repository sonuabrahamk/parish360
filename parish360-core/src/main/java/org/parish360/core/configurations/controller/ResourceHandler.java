package org.parish360.core.configurations.controller;

import jakarta.validation.Valid;
import org.parish360.core.configurations.dto.ResourceInfo;
import org.parish360.core.configurations.service.ResourceManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/configurations/resources")
public class ResourceHandler {
    private final ResourceManager resourceManager;

    public ResourceHandler(ResourceManager resourceManager) {
        this.resourceManager = resourceManager;
    }

    @PostMapping
    public ResponseEntity<ResourceInfo> createResource(@PathVariable("parishId") String parishId,
                                                       @Valid @RequestBody ResourceInfo resourceInfo) {
        return ResponseEntity.ok(resourceManager.createResource(parishId, resourceInfo));
    }

    @PatchMapping("{resourceId}")
    public ResponseEntity<ResourceInfo> updateResource(@PathVariable("parishId") String parishId,
                                                       @PathVariable("resourceId") String resourceId,
                                                       @Valid @RequestBody ResourceInfo resourceInfo) {
        return ResponseEntity.ok(resourceManager.updateResource(parishId, resourceId, resourceInfo));
    }

    @GetMapping("{resourceId}")
    public ResponseEntity<ResourceInfo> getResource(@PathVariable("parishId") String parishId,
                                                    @PathVariable("resourceId") String resourceId) {
        return ResponseEntity.ok(resourceManager.getResource(parishId, resourceId));
    }

    @GetMapping
    public ResponseEntity<List<ResourceInfo>> getListOfResources(@PathVariable("parishId") String parishId,
                                                                 @RequestParam(value = "isActive", required = false)
                                                                 Boolean isActive) {
        return ResponseEntity.ok(resourceManager.getListOfResource(parishId, isActive));
    }

    @DeleteMapping("{resourceId}")
    public ResponseEntity<Object> deleteResource(@PathVariable("parishId") String parishId,
                                                 @PathVariable("resourceId") String resourceId) {
        resourceManager.deleteResource(parishId, resourceId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
