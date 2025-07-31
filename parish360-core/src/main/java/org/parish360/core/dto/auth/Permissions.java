package org.parish360.core.dto.auth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Data
@NoArgsConstructor
public class Permissions {
    @JsonProperty("data-owner")
    private DataOwner dataOwner = new DataOwner();
    private Modules modules = new Modules();

    @Data
    @NoArgsConstructor
    public static class DataOwner {
        private Set<UUID> diocese = new HashSet<>();
        private Set<UUID> forane = new HashSet<>();
        private Set<UUID> parish = new HashSet<>();
    }

    @Data
    @NoArgsConstructor
    public static class Modules {
        private Set<String> create = new HashSet<>();
        private Set<String> edit = new HashSet<>();
        private Set<String> view = new HashSet<>();
        private Set<String> delete = new HashSet<>();
    }
}
