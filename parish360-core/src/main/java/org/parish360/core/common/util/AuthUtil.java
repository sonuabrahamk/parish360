package org.parish360.core.common.util;

import org.parish360.core.auth.dto.UserPrincipal;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class AuthUtil {

    public static String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserPrincipal) {
            return ((UserPrincipal) auth.getPrincipal()).getUsername(); // This will be the `sub` from the JWT
        }
        return null;
    }

    public static String getCurrentUserCurrency() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserPrincipal) {
            return ((UserPrincipal) auth.getPrincipal()).getCurrency(); // This will be the `sub` from the JWT
        }
        return null;
    }

    public static String getCurrentUserTimezone() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserPrincipal) {
            return ((UserPrincipal) auth.getPrincipal()).getTimeZone(); // This will be the `sub` from the JWT
        }
        return null;
    }

    public static String getCurrentUserLocale() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserPrincipal) {
            return ((UserPrincipal) auth.getPrincipal()).getLocale(); // This will be the `sub` from the JWT
        }
        return null;
    }
}
