package org.parish360.core.auth;

import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.parish360.core.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.UUID;

@Component
public class AuthFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getRequestURI();
        return path.startsWith("/auth") || path.startsWith("/health");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (AuthConstants.AUTH_COOKIE_NAME.equals(cookie.getName())) {
                    try {
                        String token = cookie.getValue();
                        String path = request.getRequestURI();
                        if (path == null || !path.startsWith(AuthConstants.APP_DOMAIN)) {
                            throw new RuntimeException("Invalid Request");
                        }
                        UUID parishId = extractParishId(path);
                        if (token != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                            if (jwtUtil.validateToken(token, parishId)) {
                                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                                        jwtUtil.extractSubject(token), null, null);

                                // This is CRUCIAL
                                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                                SecurityContextHolder.getContext().setAuthentication(authToken);
                            }

                            // refresh cookie and add to response
                            Cookie refreshCookie = new Cookie(AuthConstants.AUTH_COOKIE_NAME, token);
                            refreshCookie.setHttpOnly(true);
                            refreshCookie.setSecure(true);
                            refreshCookie.setPath("/");
                            refreshCookie.setMaxAge(AuthConstants.COOKIE_EXPIRY_SECONDS);
                            response.addCookie(refreshCookie);
                        }
                    } catch (JwtException e) {
                        // handle invalid jwt
                    }
                }
            }
        }

        filterChain.doFilter(request, response);
    }

    private UUID extractParishId(String path) {
        var pathArray = path.split("/");
        if (pathArray.length == 0) {
            throw new RuntimeException("Could not extract parish ID");
        }
        return UUID.fromString(pathArray[2]);
    }
}
