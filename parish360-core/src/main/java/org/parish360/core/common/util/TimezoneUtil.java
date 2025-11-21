package org.parish360.core.common.util;

import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;

@Component
public class TimezoneUtil {
    public static Instant asInstant(LocalDateTime dateTime) {
        String timezone = "UTC";
        if (AuthUtil.getCurrentUserTimezone() != null) {
            timezone = AuthUtil.getCurrentUserTimezone();
        }
        ZoneId zoneId = ZoneId.of(timezone);
        return dateTime.atZone(zoneId).toInstant();
    }

    public static LocalDateTime asLocalDateTime(Instant dateTime) {
        String timezone = "UTC";
        if (AuthUtil.getCurrentUserTimezone() != null) {
            timezone = AuthUtil.getCurrentUserTimezone();
        }
        ZoneId zoneId = ZoneId.of(timezone);
        return dateTime.atZone(zoneId).toLocalDateTime();
    }

    public static LocalDate asLocalDate(Instant dateTime) {
        String timezone = "UTC";
        if (AuthUtil.getCurrentUserTimezone() != null) {
            timezone = AuthUtil.getCurrentUserTimezone();
        }
        ZoneId zoneId = ZoneId.of(timezone);
        return dateTime.atZone(zoneId).toLocalDate();
    }
}
