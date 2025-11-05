package org.parish360.core.common.util;

import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;

@Component
public class TimezoneUtil {
    public Instant asInstant(LocalDateTime dateTime) {
        String timezone = "UTC";
        if (AuthUtil.getCurrentUserTimezone() != null) {
            timezone = AuthUtil.getCurrentUserTimezone();
        }
        ZoneId zoneId = ZoneId.of(timezone);
        return dateTime.atZone(zoneId).toInstant();
    }

    public LocalDateTime asLocalDateTime(Instant dateTime) {
        String timezone = "UTC";
        if (AuthUtil.getCurrentUserTimezone() != null) {
            timezone = AuthUtil.getCurrentUserTimezone();
        }
        ZoneId zoneId = ZoneId.of(timezone);
        return dateTime.atZone(zoneId).toLocalDateTime();
    }
}
