package org.parish360.core.common.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.parish360.core.auth.AuthConstants;
import org.parish360.core.auth.dto.Permissions;
import org.parish360.core.common.enums.EntityType;
import org.parish360.core.dao.entities.usermanagement.User;
import org.parish360.core.error.exception.AccessDeniedException;
import org.parish360.core.error.exception.ResourceNotFoundException;
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

    public boolean validateToken(String token, String path, String method) {
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(SECRET_KEY)
                .build()
                .parseClaimsJws(token)
                .getBody();
        Object permissionsClaim = claims.get(AuthConstants.TOKEN_PERMISSIONS);
        ObjectMapper mapper = new ObjectMapper();
        Permissions permissions = mapper.convertValue(permissionsClaim, Permissions.class);
        return claims.getSubject() != null
                && (!claims.getExpiration().before(new Date()))
                && isPermissionsAndPathValid(permissions, path, method);
    }

    private boolean isPermissionsAndPathValid(Permissions permissions, String path, String method) {
        validatePermissionsAndPathExist(permissions, path);

        String[] pathArray = path.split("/");
        validatePath(pathArray);

        UUID parishId = UUID.fromString(pathArray[2]);
        validateParishPermission(permissions, parishId);

        String context = pathArray[3];
        validateModulePermission(permissions, context, method);

        return true;
    }

    private void validatePermissionsAndPathExist(Permissions permissions, String path) {
        if (permissions == null || path == null) {
            throw new AccessDeniedException("invalid permission or endpoint");
        }
    }

    private void validatePath(String[] pathArray) {
        if (pathArray.length < 3 || !EntityType.PARISH.toString().equalsIgnoreCase(pathArray[1])) {
            throw new ResourceNotFoundException("invalid endpoint");
        }
    }

    private void validateParishPermission(Permissions permissions, UUID parishId) {
        if (!permissions.getDataOwner().getParish().contains(parishId)) {
            throw new AccessDeniedException("data owner permission is not valid");
        }
    }

    private void validateModulePermission(Permissions permissions, String context, String method) {
        var modules = permissions.getModules();
        boolean hasPermission;

        switch (method) {
            case "GET" -> hasPermission = modules.getView().contains(context);
            case "POST", "PUT" -> hasPermission = modules.getCreate().contains(context);
            case "PATCH" -> hasPermission = modules.getEdit().contains(context);
            case "DELETE" -> hasPermission = modules.getDelete().contains(context);
            default -> throw new AccessDeniedException("invalid request method");
        }

        if (!hasPermission) {
            throw new AccessDeniedException("permission denied to " + context);
        }
    }

}
