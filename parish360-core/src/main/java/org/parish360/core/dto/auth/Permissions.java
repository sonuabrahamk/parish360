package org.parish360.core.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Permissions {
    private Set<String> create = new HashSet<>();
    private Set<String> edit = new HashSet<>();
    private Set<String> view = new HashSet<>();
    private Set<String> delete = new HashSet<>();

    public void addCreate(String module) {
        this.view.add(module);
    }

    public void addEdit(String module) {
        this.view.add(module);
    }

    public void addView(String module) {
        this.view.add(module);
    }

    public void addDelete(String module) {
        this.view.add(module);
    }
}
