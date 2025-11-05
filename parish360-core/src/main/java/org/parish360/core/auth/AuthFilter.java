package org.parish360.core.auth;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.parish360.core.auth.dto.UserPrincipal;
import org.parish360.core.common.util.JwtUtil;
import org.parish360.core.error.exception.UnAuthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.HandlerExceptionResolver;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Component
public class AuthFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private HandlerExceptionResolver handlerExceptionResolver;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getRequestURI();
        return path.startsWith("/auth")
                || path.startsWith("/health")
                || path.startsWith("/dataowner");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {

        try {
            Cookie[] cookies = request.getCookies();
            if (cookies == null) {
                throw new UnAuthorizedException("cookie not found");
            }

            Cookie authCookie = Arrays.stream(cookies)
                    .filter(c -> AuthConstants.AUTH_COOKIE_NAME.equals(c.getName()))
                    .findFirst()
                    .orElseThrow(() -> new UnAuthorizedException("cookie not found"));

            String token = authCookie.getValue();
            String path = request.getRequestURI();

            if (token != null
                    && SecurityContextHolder.getContext().getAuthentication() == null
                    && jwtUtil.validateToken(token, path, request.getMethod())) {

                UserPrincipal userPrincipal = UserPrincipal.builder()
                        .username(jwtUtil.extractSubject(token))
                        .timeZone(jwtUtil.extractTimezone(token))
                        .locale(jwtUtil.extractLocale(token))
                        .currency(jwtUtil.extractCurrency(token))
                        .build();

                List<GrantedAuthority> authorities =
                        Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));

                UsernamePasswordAuthenticationToken authToken =
                        new UsernamePasswordAuthenticationToken(userPrincipal, null, authorities);

                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                // ✅ Set into context
                SecurityContextHolder.getContext().setAuthentication(authToken);

                // Refresh cookie
                Cookie refreshCookie = new Cookie(AuthConstants.AUTH_COOKIE_NAME, token);
                refreshCookie.setHttpOnly(true);
                refreshCookie.setSecure(true);
                refreshCookie.setPath("/");
                refreshCookie.setMaxAge(AuthConstants.COOKIE_EXPIRY_SECONDS);
                response.addCookie(refreshCookie);
            }

            filterChain.doFilter(request, response);

        } catch (Exception e) {
            handlerExceptionResolver.resolveException(request, response, null,
                    new UnAuthorizedException(e.getMessage()));
        }
    }
}
