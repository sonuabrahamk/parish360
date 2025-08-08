package org.parish360.core;

import org.parish360.core.common.util.UUIDUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@SpringBootApplication
@RestController
public class Parish360CoreApplication {
    public static void main(String[] args) {
        SpringApplication.run(Parish360CoreApplication.class, args);
    }

    @GetMapping("/health")
    public ResponseEntity<?> healthCheck() {
        return ResponseEntity.ok("Healthy: " + UUIDUtil.encode(UUID.fromString("2b4173dd-3925-4267-9358-c49f5f307dfa")));
    }
}
