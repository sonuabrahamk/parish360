package org.parish360.core.auth.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Data
@NoArgsConstructor
public class Permissions {
    private DataOwner dataOwner = new DataOwner();
    private Modules modules = new Modules();

    @Data
    @NoArgsConstructor
    public static class DataOwner {
        private Set<String> diocese = new HashSet<>();
        private Set<String> forane = new HashSet<>();
        private Set<String> parish = new HashSet<>();
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
