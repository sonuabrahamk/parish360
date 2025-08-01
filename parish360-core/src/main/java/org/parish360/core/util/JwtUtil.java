package org.parish360.core.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.parish360.core.dto.auth.Permissions;
import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.service.auth.AuthConstants;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.UUID;

@Component
public class JwtUtil {
    private final Key SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    public String generateToken(User user, Permissions permissions) {
        return Jwts.builder()
                .setSubject(user.getEmail())
                .claim(AuthConstants.TOKEN_PERMISSIONS, permissions)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60))
                .signWith(SECRET_KEY)
                .compact();
    }

    public String extractSubject(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(SECRET_KEY)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public boolean validateToken(String token, UUID parishId) {
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(SECRET_KEY)
                .build()
                .parseClaimsJws(token)
                .getBody();
        Object permissionsClaim = claims.get(AuthConstants.TOKEN_PERMISSIONS);
        ObjectMapper mapper = new ObjectMapper();
        Permissions permissions = mapper.convertValue(permissionsClaim, Permissions.class);
        System.out.println("Permissions: " + permissions);
        if (claims.getSubject() != null
                && (!claims.getExpiration().before(new Date()))
                && (permissions != null)
                && permissions.getDataOwner().getParish().contains(parishId)) {
            return true;
        }
        return false;
    }
}
