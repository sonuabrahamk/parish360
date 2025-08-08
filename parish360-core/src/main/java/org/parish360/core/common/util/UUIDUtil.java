package org.parish360.core.common.util;

import org.mapstruct.Mapper;
import org.mapstruct.Named;

import java.util.Base64;
import java.util.UUID;

@Mapper(componentModel = "spring")
public class UUIDUtil {
    @Named("uuidToBase64")
    public static String encode(UUID uuid) {
        if (uuid == null) {
            return null;
        }
        byte[] bytes = asBytes(uuid);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes); // URL-safe
    }

    @Named("base64ToUuid")
    public static UUID decode(String shortId) {
        if (shortId == null) {
            return null;
        }
        byte[] bytes = Base64.getUrlDecoder().decode(shortId);
        return asUuid(bytes);
    }

    private static byte[] asBytes(UUID uuid) {
        long msb = uuid.getMostSignificantBits();
        long lsb = uuid.getLeastSignificantBits();
        byte[] buffer = new byte[16];
        for (int i = 0; i < 8; i++) buffer[i] = (byte) (msb >>> (8 * (7 - i)));
        for (int i = 8; i < 16; i++) buffer[i] = (byte) (lsb >>> (8 * (15 - i)));
        return buffer;
    }

    private static UUID asUuid(byte[] bytes) {
        long msb = 0;
        long lsb = 0;
        for (int i = 0; i < 8; i++) msb = (msb << 8) | (bytes[i] & 0xff);
        for (int i = 8; i < 16; i++) lsb = (lsb << 8) | (bytes[i] & 0xff);
        return new UUID(msb, lsb);
    }
}
