package org.parish360.core;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Parish360CoreApplication {
    public static void main(String[] args) {
        SpringApplication.run(Parish360CoreApplication.class, args);
    }

    @GetMapping("/health")
    public ResponseEntity<?> healthCheck() {
        return ResponseEntity.ok("Parish360 app is running successfully!!");
    }
}
